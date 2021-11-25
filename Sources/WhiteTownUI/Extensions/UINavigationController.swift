//
//  UINavigationController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 02/10/2020.
//

import UIKit

public extension UINavigationController {

    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}

extension UITabBarController {

    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = selectedViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = selectedViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = selectedViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController?.childForStatusBarStyle ?? selectedViewController
    }

}

extension UINavigationController {

    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }

    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}

public extension UINavigationController {

    func popBack(_ nb: Int) {
        let vcs: [UIViewController] = self.viewControllers
        let index = vcs.count - nb - 1
        if index >= 0 {
            self.popToViewController(vcs[index], animated: true)
        }
    }

    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        var viewControllers: [UIViewController] = self.viewControllers
        viewControllers = viewControllers.reversed()
        for currentViewController in viewControllers {
            if currentViewController .isKind(of: toControllerType) {
                self.popToViewController(currentViewController, animated: true)
                break
            }
        }
    }

}

public extension UINavigationController {

    func replaceLastViewController(with vc: UIViewController) {
        var vcs = self.viewControllers
        vcs.removeLast()
        vcs.append(vc)
        self.setViewControllers(vcs, animated: true)
    }

    func replaceAllControllers(with vc: UIViewController) {
        var vcs = self.viewControllers
        while vcs.count > 1 {
            vcs.removeLast()
        }
        vcs.append(vc)
        self.setViewControllers(vcs, animated: true)
    }

}
