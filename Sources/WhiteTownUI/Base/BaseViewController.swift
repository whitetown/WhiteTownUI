//
//  BaseViewController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 30/09/2020.
//

import UIKit

open class BaseViewController: UIViewController {

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }

    open override var shouldAutorotate: Bool {
        return false
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    //internal var placeholderView = PlaceholderView()

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backButtonTitle = ""
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = UIColor.appBackground
    }

    public var keyboardHeight: CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                self.onKeyboardChange(self.keyboardHeight)
            }
        }
    }

    public func subscribeToKeyboardEvents() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object:nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object:nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object:nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object:nil)

//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrame), name: UIResponder.keyboardDidChangeFrameNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
    }

    public func unsubscribeFromKeyboardEvents() {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object:nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object:nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object:nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object:nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object:nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
    }

    @objc func keyboardDidShow(_ notification: Notification) {
        getKeyboardHeightFromNotification(notification)
    }

    @objc func keyboardDidHide(_ notification: Notification) {
        getKeyboardHeightFromNotification(notification)
    }

    @objc func keyboardDidChangeFrame(_ notification: Notification) {
        getKeyboardHeightFromNotification(notification)
    }

    @discardableResult func getKeyboardHeightFromNotification(_ notification: Notification) -> CGFloat {
        let targetFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        self.keyboardHeight = max(0, self.view.height + self.view.frame.origin.y - targetFrame.minY)
        return self.keyboardHeight
    }

    open func onKeyboardChange(_ height: CGFloat) {

    }

}

public extension BaseViewController {

    func hidePlaceholder() {
        //self.placeholderView.removeFromSuperview()
    }

    func showPlaceholder(image: UIImage? = nil, title: String? = nil, subtitle: String? = nil,
                         shiftVertically: CGFloat = 0) {
//        if let _ = self.placeholderView.superview {
//
//        } else {
//            self.view.addSubview(self.placeholderView)
//            self.view.bringSubviewToFront(self.placeholderView)
//            self.placeholderView.snp.makeConstraints { (make) in
//                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview().offset(shiftVertically)
//            }
//        }
//
//        self.placeholderView.iv.image = image ?? UIImage(systemName: "xmark.shield")
//        self.placeholderView.title.text = title
//        self.placeholderView.subtitle.text = subtitle
    }
}
