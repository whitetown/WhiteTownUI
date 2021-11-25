//
//  UIApplication.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 02/10/2020.
//

import UIKit
import AVKit
import StoreKit

public extension UIApplication {

    static func setupBackButton() {
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -UIScreen.main.bounds.size.width*2, vertical: -UIScreen.main.bounds.size.height*2), for: UIBarMetrics.default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -UIScreen.main.bounds.size.width*2, vertical: -UIScreen.main.bounds.size.height*2), for: UIBarMetrics.compact)
    }

    static func setupVideo() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
    }

    static func requestReview() {
        if #available(iOS 14.0, *) {
            if let windowScene = UIApplication.shared.windows.first?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }

    static func askForReview(_ appStoreId: String) {
        if let url = URL(string: "https://apps.apple.com/app/id\(appStoreId)?action=write-review&mt=8") {
            UIApplication.shared.open(url, options: [:])
        }
    }

    static func openInAppStore(_ appStoreId: String) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/apple-store/id\(appStoreId)?mt=8") else { return }
        UIApplication.shared.open(url)
    }

    static func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

}

public extension UIApplication {

    static var topKeyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    @objc static func topViewController(controller: UIViewController? = UIApplication.topKeyWindow?.rootViewController) -> UIViewController?
    {
        if let navigationController = controller as? UINavigationController
        {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController
        {
            if let selected = tabController.selectedViewController
            {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController
        {
            return topViewController(controller: presented)
        }
        return controller
    }
}
