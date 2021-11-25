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

        let ac = UIAlertController(title: "Location setting are disabled".unlocalized,
                                       message: "Go to your phone settings and allow app to use your location".unlocalized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".unlocalized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".unlocalized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func bluetoothWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Bluetooth permision not given".unlocalized,
                                       message: "Go to your phone settings and allow app to use bluetooth.".unlocalized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".unlocalized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".unlocalized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func photoWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Photo library permision not given".unlocalized,
                                       message: "Go to your phone settings and allow app to use photo library".unlocalized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".unlocalized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".unlocalized, style: .default, handler: { (_) in
            UIApplication.openSystemSettings()
        }))

        return ac
    }

    static func cameraWarning() -> UIAlertController  {

        let ac = UIAlertController(title: "Camera permision not given".unlocalized,
                                       message: "Go to your phone settings and allow app to use camera".unlocalized,
                                       preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK".unlocalized, style: .default, handler: { (_) in

        }))

        ac.addAction(UIAlertAction(title: "Settings".unlocalized, style: .default, handler: { (_) in
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

        ac.addAction(UIAlertAction(title: "Take photo".unlocalized,
                                   style: .default, handler: { (_) in
                                    ac.dismiss(animated: true) {
                                        onCamera()
                                    }
                                   }))

        ac.addAction(UIAlertAction(title: "Choose photo".unlocalized,
                                   style: .default, handler: { (_) in
                                    ac.dismiss(animated: true) {
                                        onLibrary()
                                    }
                                   }))

        ac.addAction(UIAlertAction(title: "Cancel".unlocalized, style: .cancel))
        return ac
    }

}
