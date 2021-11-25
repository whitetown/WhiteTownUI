//
//  BaseTabBarController.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 03/12/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

open class BaseTabBarController: UITabBarController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupTabbar()
    }

    func setupTabbar() {

        if #available(iOS 13.0, *) {
            let appearance = self.tabBar.standardAppearance.copy()

            //appearance.backgroundColor = .clear

            let inactiveTextAttributes: [NSAttributedString.Key : Any] = [:
                //NSAttributedString.Key.foregroundColor: UIColor.primaryButtonColor,
            ]

            let selectedTextAttributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.foregroundColor: UIColor.primaryColor,
            ]

            appearance.stackedLayoutAppearance.normal.titleTextAttributes = inactiveTextAttributes
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = inactiveTextAttributes
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = inactiveTextAttributes

            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTextAttributes

            //appearance.backgroundColor = UIColor.appBackground
            //appearance.backgroundImage = UIImage.image(with: .clear)
            //appearance.shadowImage = UIImage.image(with: .clear)
            //appearance.shadowColor = UIColor.primaryButtonColor
            appearance.stackedItemPositioning = .fill

            self.tabBar.standardAppearance = appearance

        }

        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor.primaryColor
//        self.tabBar.barTintColor = UIColor.appBackground
//        self.tabBar.unselectedItemTintColor = UIColor.tabbarInactiveColor
//        self.tabBar.backgroundColor = UIColor.appBackground

        //self.tabBar.backgroundImage = UIImage.image(with: .clear)
        //self.tabBar.shadowImage = UIImage.image(with: .clear)
    }

}

