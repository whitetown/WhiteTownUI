//
//  RootController.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 03/12/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit
import WhiteTownUI

class RootController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeUI()
        initialize()
    }
}

private extension RootController {

    func customizeUI() {

//        ColorSet.shared.setColors([
//            .navColor:  (light: .clear, dark: .clear),
//            .navColorX: (light: UIColor(hex: "#ff5524"), dark: UIColor(hex: "#ff5524")),
//            .primaryColor: (light: UIColor(hex: "#ff5524"), dark: UIColor(hex: "#ff5524")),
//            .secondaryColor: (light: UIColor(hex: "#48b762"), dark: UIColor(hex: "#48b762")),
//            .accentColor: (light: UIColor(hex: "#ff5524"), dark: UIColor(hex: "#ff5524")),
//        ])

        if #available(iOS 13.0, *) {
            let appearance = self.tabBar.standardAppearance.copy()

            //appearance.backgroundColor = .clear

            let inactiveTextAttributes: [NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.navColorX.withAlphaComponent(0.8),
            ]

            let selectedTextAttributes: [NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.navColorX,
                .font: UIFont.boldSystemFont(ofSize: 11),
            ]

            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.navColorX.withAlphaComponent(0.8)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = inactiveTextAttributes
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = inactiveTextAttributes
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = inactiveTextAttributes

            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.navColorX
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTextAttributes

            appearance.backgroundColor = UIColor.navColor
            //appearance.backgroundImage = UIImage.image(with: .clear)
            //appearance.shadowImage = UIImage.image(with: .clear)
            //appearance.shadowColor = UIColor.primaryButtonColor
            appearance.stackedItemPositioning = .fill

            self.tabBar.standardAppearance = appearance

        }

        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor.navColorX
        self.tabBar.unselectedItemTintColor = UIColor.navColorX.withAlphaComponent(0.8)
    }

    func initialize() {

        let vc1 = DemoTableViewController()
        let vc2 = DemoScanViewController()
        let vc3 = DemoSearchViewController()
        let vc4 = DemoLogsViewController()

        let nc1 = BaseNavigationController(rootViewController: vc1)
        let nc2 = BaseNavigationController(rootViewController: vc2)
        let nc3 = BaseNavigationController(rootViewController: vc3)
        let nc4 = BaseNavigationController(rootViewController: vc4)

        nc1.tabBarItem = UITabBarItem(title: "Table".unlocalized, image: UIImage(named: "table"), tag: 0)
        nc2.tabBarItem = UITabBarItem(title: "Scan".unlocalized, image: UIImage(named: "scan"), tag: 1)
        nc3.tabBarItem = UITabBarItem(title: "Search".unlocalized, image: UIImage(named: "search"), tag: 2)
        nc4.tabBarItem = UITabBarItem(title: "Logs".unlocalized, image: UIImage(named: "logs"), tag: 3)

        self.viewControllers = [
            nc1,
            nc2,
            nc3,
            nc4,
            ]

    }

}
