//
//  UIColor.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 13/03/2021.
//

import UIKit

public extension UIColor {

    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return dark
                default:
                    return light
                }
            }
        } else {
            return light
        }
    }

}

public extension UIColor {

    convenience init(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") || hex.hasPrefix("0x")  {
            let start = hex.index(hex.startIndex, offsetBy: hex.hasPrefix("#") ? 1 : 2)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else {
                if hexColor.count == 6 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        b = CGFloat(hexNumber & 0x000000ff) / 255
                        a = 1

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }
        }

        self.init(red: 1, green: 0, blue: 0, alpha: 1)
    }

    convenience init(rgba r: Int, _ g: Int, _ b: Int, _ a: CGFloat = 1) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
}

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}

public extension UIColor {

    var hexString: String {
        let components = cgColor.components
        let r: CGFloat = components?[safe: 0] ?? 0.0
        let g: CGFloat = components?[safe: 1] ?? 0.0
        let b: CGFloat = components?[safe: 2] ?? 0.0
        let a: CGFloat = components?[safe: 3] ?? 1.0

        let result = a == 1
            ? String(format: "#%02lX%02lX%02lX",
                    lroundf(Float(r * 255)),
                    lroundf(Float(g * 255)),
                    lroundf(Float(b * 255))
                    )
            : String(format: "#%02lX%02lX%02lX%02lX",
                    lroundf(Float(r * 255)),
                    lroundf(Float(g * 255)),
                    lroundf(Float(b * 255)),
                    lroundf(Float(a * 255))
                    )

        return result
    }
}
