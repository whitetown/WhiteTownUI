//
//  UIAlertController.swift
//  installapp
//
//  Created by Sergey Chehuta on 03/03/2021.
//  Copyright © 2021 WhiteTown. All rights reserved.
//

import UIKit

public extension UIAlertController {

    static func locationWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Location setting are disabled".localized,
                                       message: "Go to your phone settings and allow app to use your location".localized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".localized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func bluetoothWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Bluetooth permision not given".localized,
                                       message: "Go to your phone settings and allow app to use bluetooth.".localized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".localized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func photoWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Photo library permision not given".localized,
                                       message: "Go to your phone settings and allow app to use photo library".localized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".localized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func cameraWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Camera permision not given".localized,
                                       message: "Go to your phone settings and allow app to use camera".localized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".localized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func selectCameraOrPhotoLibrary(onCamera: @escaping ()->Void, onLibrary: @escaping ()->Void ) -> UIAlertController?  {

        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return nil
        }

        let ac = UIAlertController(title: nil,
                                   message: nil,
                                   preferredStyle: .actionSheet)

        ac.addAction(UIAlertAction(title: "Take photo".localized,
                                   style: .default, handler: { (_) in
                                    ac.dismiss(animated: true) {
                                        onCamera()
                                    }
                                   }))

        ac.addAction(UIAlertAction(title: "Choose photo".localized,
                                   style: .default, handler: { (_) in
                                    ac.dismiss(animated: true) {
                                        onLibrary()
                                    }
                                   }))

        ac.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        return ac
    }

}
