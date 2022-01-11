//
//  UIViewController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit
import AVKit
import SafariServices
import SwiftMessages

public extension UIViewController {

    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.showMessageX(error.localizedDescription, title: "error".localized, theme: .error)
        }
    }

    func showMessage(_ message: String,
                     title: String = "",
                     theme: Theme = .info,
                     duration: TimeInterval = 3,
                     completion: (()->Void)? = nil) {
        DispatchQueue.main.async {
            self.showMessageX(message, title: title, theme: theme, duration: duration, completion: completion)
        }
    }

    func showMessageX(_ message: String,
                     title: String = "",
                     theme: Theme = .info,
                     duration: TimeInterval = 3,
                     completion: (()->Void)? = nil) {

        var config = SwiftMessages.Config()
//        if let nc = self.navigationController {
//            config.presentationContext = .viewController(nc)
//        } else {
            config.presentationContext = .window(windowLevel: .statusBar)
//        }
        config.duration = .seconds(seconds: duration)

        let view = MessageView.viewFromNib(layout: .cardView)

        view.titleLabel?.isHidden = title.count == 0
        view.configureTheme(theme)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)

        view.tapHandler = { _ in
            SwiftMessages.hide()
            completion?()
        }
        

        SwiftMessages.show(config: config, view: view)
    }

}

public extension UIViewController {

    func showLoading(insets: UIEdgeInsets = .zero,
                     wh: CGFloat = loadingSize,
                     backgroundColor: UIColor? = UIColor.black.withAlphaComponent(0.15)) {
        self.view.showLoading(insets: insets, wh: wh, backgroundColor: backgroundColor)
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.view.hideLoading()
        }
    }

}

public extension UIViewController {

    func openURLinsideApp(url: URL?) {
        guard let url = httpsURL(url: url) else { return }
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true, completion: nil)
    }

    func openURL(url: URL?) {
        guard let url = httpsURL(url: url) else { return }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:]) { (result) in
                 if !result {
                    self.openURLinsideApp(url: url)
                 }
             }
        }
    }

    func httpsURL(url: URL?) -> URL? {
        if url?.absoluteString.lowercased().hasPrefix("http") == true { return url }
        return URL(string: "https://" + (url?.absoluteString ?? "whitetown.com"))
    }

    func open(urlScheme: URL?, or webUrl: URL?) {
        if let url = urlScheme,
           UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { (result) in
                    if !result {
                        //self.openURLinsideApp(url: webUrl)
                    }
            }
        } else {
            self.openURLinsideApp(url: webUrl)
        }
    }

}

public extension UIViewController {

    var topbarHeight: CGFloat {
        (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

/*

 public extension UIViewController {

     func showError(_ error: Error) {
         DispatchQueue.main.async {
             self.showMessageX(error.localizedDescription, title: "error".localized, theme: .danger)
         }
     }

     func showMessage(_ message: String,
                      title: String = "",
                      theme: BannerStyle = .info,
                      duration: TimeInterval = 3,
                      completion: (()->Void)? = nil) {
         DispatchQueue.main.async {
             self.showMessageX(message, title: title, theme: theme, duration: duration, completion: completion)
         }
     }

     func showMessageX(_ message: String,
                      title: String = "",
                      theme: BannerStyle = .info,
                      duration: TimeInterval = 3,
                      completion: (()->Void)? = nil) {

         let banner = FloatingNotificationBanner(title: title,
                                                 subtitle: message,
                                                 //leftView: <#T##UIView?#>,
                                                 style: theme)
         banner.show()

         var config = SwiftMessages.Config()
 //        if let nc = self.navigationController {
 //            config.presentationContext = .viewController(nc)
 //        } else {
             config.presentationContext = .window(windowLevel: .statusBar)
 //        }
         config.duration = .seconds(seconds: duration)

         let view = MessageView.viewFromNib(layout: .cardView)

         view.titleLabel?.isHidden = title.count == 0
         view.configureTheme(theme)
         view.configureDropShadow()
         view.button?.isHidden = true
         view.configureContent(title: title, body: message)

         view.tapHandler = { _ in
             SwiftMessages.hide()
             completion?()
         }


         SwiftMessages.show(config: config, view: view)
     }

 }
 */
