//
//  SSScanController.swift
//  SynchroSnap
//
//  Created by Sergey Chehuta on 11/03/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit
import AVFoundation

open class BaseScanController: BaseViewController {

    private let scannerHole = ScannerHole()
    private let scannerRect = ScannerRect()
    private let errorRect = ScannerRect()
    public  let messageLabel = UILabel(style: .heavy, size: 24, color: .white, align: .center, lines: 0, scale: 0.5)
    public  let errorLabel = UILabel(style: .heavy, size: 24, color: .red, align: .center, lines: 0, scale: 0.5)

    internal let editContainer = UIView()
    internal let kbdButton = WTButton()
    internal let editField = WTTextField()
    internal let confirmButton = WTButton()
    internal let hexKeyboard = HexKeyboard(frame: CGRect(x: 0, y: 0, width: 320, height: 240))

    private let captureSession = AVCaptureSession()
    private let cameraOutput  = AVCaptureMetadataOutput()

    private var camera: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
    private var input: AVCaptureDeviceInput?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    private var reconnectTimer: Timer?
    private var pauseScan = false

    public var allowManualEntering = false {
        didSet {
            updateManual()
        }
    }
    public var onSearch: ((String) -> Void)?
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    open override var shouldAutorotate: Bool {
        return false
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        addCameraPreview()
        addSubviews()
        initialize()
        initializeEditor()
        self.allowManualEntering = true
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        DispatchQueue.global().async {
            self.captureSession.startRunning()
            self.startScanning()
        }
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    private func addSubviews() {

        self.view.addSubview(self.scannerHole)
        self.scannerHole.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.view.addSubview(self.scannerRect)
        self.scannerRect.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(UIDevice.current.userInterfaceIdiom == .pad ? 300 : 218)
        }

        self.errorRect.color = UIColor.red
        self.errorRect.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        self.errorRect.alpha = 0
        self.scannerRect.addSubview(self.errorRect)
        self.errorRect.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        let isSmallDevice = self.view.height < 600

        self.view.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(isSmallDevice ? 20 : 40)
            make.bottom.equalTo(self.scannerRect.snp.top).offset(isSmallDevice ? -10 : -30)
        }
        
        self.view.addSubview(self.errorLabel)
        self.errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scannerRect.snp.bottom).offset(isSmallDevice ? 10 : 30)
            make.left.right.equalToSuperview().inset(isSmallDevice ? 20 : 40)
        }

    }

    private func initialize() {
        self.view.backgroundColor = .black
        self.messageLabel.text = "Scan QR-code from a sensor".localized
    }

    @objc func close() {
        if let nc = self.navigationController {
            nc.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func addCameraPreview() {
                
        guard let camera = self.camera else { return }
        self.input = try? AVCaptureDeviceInput(device: camera)
        guard let input = self.input else { return }

        self.captureSession.addInput(input)
        self.captureSession.sessionPreset = AVCaptureSession.Preset.photo

        if (captureSession.canAddOutput(self.cameraOutput)) {
            captureSession.addOutput(self.cameraOutput)
        }
        self.cameraOutput.setMetadataObjectsDelegate(self, queue: .main)
        self.cameraOutput.metadataObjectTypes = [.qr, .ean13, .ean8, .code128]

        self.captureSession.startRunning()
                        
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        previewLayer.bounds = self.view.bounds
        previewLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        let cameraPreview = UIView(frame: self.view.bounds)
        cameraPreview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        cameraPreview.layer.addSublayer(previewLayer)
        self.previewLayer = previewLayer
        
        self.view.addSubview(cameraPreview)
        startScanning()
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scannerHole.setNeedsDisplay()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureVideoOrientation()
        self.scannerHole.setNeedsDisplay()
    }
    
    private func configureVideoOrientation() {
        self.previewLayer?.frame = self.view.bounds
        self.previewLayer?.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)

        if UIDevice.current.userInterfaceIdiom == .pad {
            if  let previewLayer = self.previewLayer,
                let connection = previewLayer.connection {
                let orientation = UIDevice.current.orientation

                if connection.isVideoOrientationSupported,
                    let videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) {
                    connection.videoOrientation = videoOrientation
                }
            }
        }
    }

    open func startScanning() {
        self.pauseScan = false
//        self.session?.startRunning()
    }

    open func pauseScanning() {
        self.pauseScan = true
    }

    open func processTheCode(_ code: String) {
        print(code) // override
    }

    open func showError(_ message: String) {
        
        self.errorLabel.text = message
        UIView.animate(withDuration: 0.25, animations: {
            self.errorLabel.alpha = 1
            self.errorRect.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseOut, animations: {
                self.errorLabel.alpha = 0
                self.errorRect.alpha = 0
            }) { _ in
                self.startScanning()
            }
        }
    }

    func initializeEditor() {
        weak var welf = self

        self.editContainer.backgroundColor = UIColor.navColor
        self.view.addSubview(self.editContainer)
        self.editContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }

        self.kbdButton.setTitle("⌨", for: .normal)
        self.kbdButton.fgColor = UIColor.navColorX
        self.editContainer.addSubview(self.kbdButton)
        self.kbdButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(44)
        }
        self.kbdButton.onTap = {
            welf?.toggleKeyboard()
        }

        self.confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.confirmButton.fgColor = UIColor.navColorX
        self.confirmButton.setTitle("Confirm".localized, for: .normal)
        self.confirmButton.sizeToFit()
        self.editContainer.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(self.confirmButton.width+16*2)
        }
        self.confirmButton.onTap = {
            welf?.onManualConfirm()
        }

        self.editField.returnKeyType = .continue
        self.editField.autocapitalizationType = .none
        self.editField.autocorrectionType = .no
        self.editField.textColor = UIColor.navColorX
        self.editField.tintColor = UIColor.navColorX
        self.editField.inactiveColor = .clear
        self.editField.activeColor = .clear
        self.editField.layer.borderColor = UIColor.clear.cgColor
        self.editField.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        self.editField.placeholderColor = UIColor.navColorX.withAlphaComponent(0.5)
        self.editField.placeholder = "Barcode/QR-code".localized
        self.editContainer.addSubview(self.editField)
        self.editField.snp.makeConstraints { (make) in
            make.leading.equalTo(self.kbdButton.snp.trailing)//.inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.trailing.equalTo(self.confirmButton.snp.leading)
        }
        self.editField.onEnter = {
            welf?.onManualConfirm()
        }

        self.editContainer.transform = CGAffineTransform(translationX: 0, y: -44)

        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tap)
    }

    @objc func onTap() {
        self.view.endEditing(true)
    }

    func updateManual() {
        if self.allowManualEntering {
            let btn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(onManual))
            self.navigationItem.rightBarButtonItems = [btn]
        } else {
            self.navigationItem.rightBarButtonItems = nil
        }
    }

    @objc func onManual() {
        UIView.animate(withDuration: 0.25) {
            if self.editContainer.tag == 0 {
                self.editContainer.transform = .identity
            } else {
                self.editContainer.transform = CGAffineTransform(translationX: 0, y: -44)
            }
        } completion: { (_) in
            self.editContainer.tag = 1 - self.editContainer.tag
            if self.editContainer.tag > 0 {
                self.editField.becomeFirstResponder()
            } else {
                self.view.endEditing(true)
            }
        }
    }

    func onManualConfirm() {
        if let text = self.editField.text, text.count > 0 {
            self.view.endEditing(true)
            processTheCode(text)
        }
    }

    func useHexKeyboard() {
        self.hexKeyboard.target = self.editField
        self.hexKeyboard.onDismiss = { [weak self] in
            self?.editField.resignFirstResponder()
        }
        self.editField.placeholder = "00000000"
        self.editField.inputView = self.hexKeyboard
        self.editField.reloadInputViews()
    }

    func useRegularKeyboard() {
        self.editField.placeholder = "Manually".localized
        self.editField.inputView = nil
        self.editField.reloadInputViews()
    }

    func toggleKeyboard() {
        if let _ = self.editField.inputView {
            useRegularKeyboard()
        } else {
            useHexKeyboard()
        }
    }

}

extension BaseScanController: AVCaptureMetadataOutputObjectsDelegate {

    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        //session?.stopRunning()
        if self.pauseScan { return }

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = readableObject.stringValue else { return }
            pauseScanning()
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            processTheCode(code)
        }
    }
}
