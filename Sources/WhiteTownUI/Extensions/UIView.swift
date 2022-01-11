//
//  UIView.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

public extension UIView {
    var x: CGFloat { self.frame.minX }
    var y: CGFloat { self.frame.minY }
    var width: CGFloat { self.frame.width }
    var height: CGFloat { self.frame.height }
}

public extension UIView {

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 19.0, -17.0, 15.0, -13.0, 10.0, -7.0, 3.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

    func addAnimation(type: CATransitionType, subtype: CATransitionSubtype, duration: TimeInterval) {

        let transition = CATransition()
        transition.duration = duration
        transition.type = type
        transition.subtype = subtype
        transition.fillMode = CAMediaTimingFillMode.both
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(transition, forKey: kCATransition)
    }

    func flip(_ duration: TimeInterval) {
        let transitionOptions: UIView.AnimationOptions = [.transitionCurlUp, .showHideTransitionViews]
        UIView.transition(with: self,
                          duration: duration,
                          options: transitionOptions,
                          animations: {
        })
    }


    func asImage(_ size: CGFloat? = nil) -> UIImage {

        let minSize = min(self.bounds.width, self.bounds.height)
        let desiredSize: CGFloat = size ?? minSize
        let scale = round(desiredSize/minSize)

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale

        let renderer = UIGraphicsImageRenderer(bounds: self.bounds, format: format)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func setGradientBackground(top: UIColor, bottom: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [top.cgColor, bottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}

public extension UIView {

    func addBlur(_ effect: UIBlurEffect.Style, alpha: CGFloat = 1) -> UIVisualEffectView {
        // create effect
        let effect = UIBlurEffect(style: effect)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.insertSubview(effectView, at: 0)
        return effectView
    }

    func removeBlur() {
        self.subviews.forEach { (v) in
            if v.isKind(of: UIVisualEffectView.self) {
                v.removeFromSuperview()
            }
        }
    }

    func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 2, cornerRadius: CGFloat = 5, dashPattern: [NSNumber] = [2,2]) {

        let shapeLayer = CAShapeLayer()

        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath

        self.layer.addSublayer(shapeLayer)
    }
}

public let loadingTag  = 2019
public let loadingIdentifier = "LoadingIdentifier"
public let loadingSize: CGFloat = 60

public extension UIView {

    func showLoading(insets: UIEdgeInsets = .zero,
                     wh: CGFloat = loadingSize,
                     backgroundColor: UIColor? = nil) {
        hideLoading()
        let lv = createLoading(insets: insets, wh: wh, backgroundColor: backgroundColor)
        self.addSubview(lv)
    }

    func hideLoading() {
        if let lv = self.subviews.filter({ $0.tag == loadingTag }).first {
            lv.removeFromSuperview()
        }
    }

    func createLoading(insets: UIEdgeInsets = .zero,
                       wh: CGFloat = loadingSize,
                       backgroundColor: UIColor? = nil) -> UIView {

        let result = UIView(frame: self.bounds.inset(by: insets))
        result.backgroundColor = backgroundColor
        result.tag = loadingTag
        result.autoresizingMask = [ .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin ]

        let naiv: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            naiv = UIActivityIndicatorView(style: .large)
        } else {
            naiv = UIActivityIndicatorView(style: .whiteLarge)
        }
        naiv.color = UIColor.textColor
        naiv.frame = CGRect(x: result.width/2-wh/2,
                            y: result.height/2-wh/2,
                            width: wh,
                            height: wh)
        naiv.autoresizingMask = [ .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin ]
        result.addSubview(naiv)
        naiv.startAnimating()

        result.accessibilityIdentifier = loadingIdentifier

        return result
    }

}

public extension UIView {

    func shadow(radius: CGFloat = 5, color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = .zero) {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }

}
