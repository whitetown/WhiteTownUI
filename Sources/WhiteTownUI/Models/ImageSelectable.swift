//
//  ImageSelectable.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 09/11/2020.
//

import UIKit
import AVFoundation
import MobileCoreServices

public protocol ImageSelectable: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func selectImageFrom(rect: CGRect, button: UIBarButtonItem?, mediaTypes: MediaTypes, allowsEditing: Bool)
    func selectImageFromCamera(mediaTypes: MediaTypes, allowsEditing: Bool)
    func selectImageFromLibrary(mediaTypes: MediaTypes, allowsEditing: Bool)
    func selectImageFromLibraryIfAllowed(mediaTypes: MediaTypes, allowsEditing: Bool)
    func processMediaInfo(_ info: [UIImagePickerController.InfoKey : Any])
    func didSelect(video: URL, thumbnail: UIImage?)
    func didSelect(image: UIImage)
}

public enum MediaTypes {
    case all
    case image
    case video

    var types: [String] {
        switch self {
        case .all:
            return [kUTTypeImage as String, kUTTypeMovie as String]
        case .image:
            return [kUTTypeImage as String]
        case .video:
            return [kUTTypeMovie as String]
        }
    }
}

extension ImageSelectable {

    public func selectImageFrom(rect: CGRect, button: UIBarButtonItem? = nil, mediaTypes: MediaTypes, allowsEditing: Bool) {
        let ac = UIAlertController.selectCameraOrPhotoLibrary {
            self.selectImageFromCamera(mediaTypes: mediaTypes, allowsEditing: allowsEditing)
        } onLibrary: {
            self.selectImageFromLibraryIfAllowed(mediaTypes: mediaTypes, allowsEditing: allowsEditing)
        }

        if let ac = ac {
            ac.popoverPresentationController?.barButtonItem = button
            ac.popoverPresentationController?.sourceRect = rect
            ac.popoverPresentationController?.sourceView = self.view

            self.present(ac, animated: true)
        } else {
            selectImageFromLibraryIfAllowed(mediaTypes: mediaTypes, allowsEditing: allowsEditing)
        }
    }

    public func selectImageFromCamera(mediaTypes: MediaTypes, allowsEditing: Bool) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) { return }

        let picker = UIImagePickerController()
        picker.allowsEditing = allowsEditing
        picker.sourceType = .camera
        picker.mediaTypes = mediaTypes.types
        picker.delegate = self
        //picker.videoExportPreset = AVAssetExportPreset1280x720
        self.present(picker, animated: true, completion: nil)
    }

    public func selectImageFromLibrary(mediaTypes: MediaTypes, allowsEditing: Bool) {
        let picker = UIImagePickerController()
        picker.allowsEditing = allowsEditing
        picker.sourceType = .photoLibrary
        picker.mediaTypes = mediaTypes.types
        picker.delegate = self
        //picker.videoExportPreset = AVAssetExportPreset1280x720
        self.present(picker, animated: true, completion: nil)
    }

    public func selectImageFromLibraryIfAllowed(mediaTypes: MediaTypes, allowsEditing: Bool) {
        weak var welf = self
        checkPhotoLibraryPermission {
            welf?.selectImageFromLibrary(mediaTypes: mediaTypes, allowsEditing: allowsEditing)
        }
    }

    public func processMediaInfo(_ info: [UIImagePickerController.InfoKey : Any]) {

        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
        if mediaType == kUTTypeMovie as String {

            guard let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
        //print(mediaType, mediaURL)

            do {
                let asset = AVURLAsset(url: mediaURL, options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                didSelect(video: mediaURL, thumbnail: thumbnail)
            } catch {

            }
        } else {
            if  let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                 ?? info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                didSelect(image: image)
            }
        }
    }

    /*


     func didSelect(image: UIImage) {
         //TODO: send image
     }

     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

         if  let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
             didSelect(image: image)
         }

         dismiss(animated: true, completion: nil)
     }

     */

}
