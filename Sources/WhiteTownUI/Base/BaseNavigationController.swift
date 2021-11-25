//
//  BaseNavigationController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 30/09/2020.
//

import UIKit

open class BaseNavigationController: UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

    open func initialize() {
        makeDefaultBar()
    }

}

public extension BaseNavigationController {

    func makeTransparentBar() {
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithTransparentBackground()
            app.titleTextAttributes = [.foregroundColor: UIColor.navColorX]
            app.largeTitleTextAttributes = [.foregroundColor: UIColor.navColorX]
            app.backgroundColor = UIColor.clear
            self.navigationBar.standardAppearance = app
            self.navigationBar.scrollEdgeAppearance = app
        } else {
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.navColorX]
            self.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.navColorX]
            self.navigationBar.backgroundColor = UIColor.clear
        }
        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.isTranslucent = true
        self.hideBottomLine(true)
    }

    func makeDefaultBar() {
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithDefaultBackground()
            app.titleTextAttributes = [.foregroundColor: UIColor.navColorX]
            app.largeTitleTextAttributes = [.foregroundColor: UIColor.navColorX]
            app.backgroundColor = UIColor.navColor
            self.navigationBar.standardAppearance = app
            self.navigationBar.scrollEdgeAppearance = app
        } else {
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.navColorX]
            self.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.navColorX]
            self.navigationBar.backgroundColor = UIColor.navColor
        }
        self.navigationBar.barTintColor = UIColor.navColor
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.navColorX
        self.hideBottomLine(true)
    }

    func hideBottomLine(_ hide: Bool) {
        let image = hide ? UIImage() : nil
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.shadowImage = image
    }

}
