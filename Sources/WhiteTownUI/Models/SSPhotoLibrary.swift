//
//  SSPhotoLibrary.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 14/03/2021.
//

import UIKit
import Photos

public protocol SSPhotoLibrary {
    func checkPhotoLibraryPermission(_ success: @escaping (()->Void))
    func checkCameraPermission(_ success: @escaping (()->Void))
}

extension UIViewController: SSPhotoLibrary {

    public func checkPhotoLibraryPermission(_ success: @escaping (()->Void)) {

        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            success()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async { success() }
                default:
                    DispatchQueue.main.async {
                        let ac = UIAlertController.photoWarning()
                        self.present(ac, animated: true)
                    }
                }
            }
        default:
            let ac = UIAlertController.photoWarning()
            self.present(ac, animated: true)
        }
    }

    public func checkCameraPermission(_ success: @escaping (()->Void)) {

        let mediaType = AVMediaType.video
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch status {
        case .authorized:
            success()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                    if granted {
                        DispatchQueue.main.async { success() }
                    } else {
                        DispatchQueue.main.async {
                            let ac = UIAlertController.cameraWarning()
                            self.present(ac, animated: true)
                        }
                    }
                }
        default:
            let ac = UIAlertController.cameraWarning()
            self.present(ac, animated: true)
        }
    }
}

