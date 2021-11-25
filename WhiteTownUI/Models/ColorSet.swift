//
//  ColorSet.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 13/03/2021.
//

import UIKit

public enum ColorKind {

    case appBackground
    case appContent

    case navColor
    case navColorX

    case accentColor

    case borderColor

    case textColor
    case secondaryTextColor

    case dangerColor
    case dangerColorX

    case primaryColor
    case primaryColorX

    case secondaryColor
    case secondaryColorX

    case groupedCellColor
    case groupedCellColorX

    case inputColor
    case inputColorX

    public var color: UIColor {
        switch self {
        case .appBackground:
            return UIColor.dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#000000"))
        case .appContent:
            return UIColor.dynamic(light: UIColor(hex: "#F7F7F7"), dark: UIColor(hex: "#1C1C1E"))
        case .navColor:
            return UIColor.dynamic(light: UIColor(hex: "#41AD49"), dark: UIColor(hex: "#41AD49"))
        case .navColorX:
            return UIColor.dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#FFFFFF"))
        case .accentColor:
            return UIColor.dynamic(light: UIColor(hex: "#41AD49"), dark: UIColor(hex: "#41AD49"))
        case .borderColor:
            return UIColor.dynamic(light: UIColor(hex: "#DDDDDD"), dark: UIColor(hex: "#636366"))
        case .textColor:
            return UIColor.dynamic(light: UIColor(hex: "#262524"), dark: UIColor(hex: "#FFFFFF"))
        case .secondaryTextColor:
            return UIColor.dynamic(light: UIColor(hex: "#6A6A6A"), dark: UIColor(hex: "#FFFFFF").withAlphaComponent(0.6))
        case .dangerColor:
            return UIColor.dynamic(light: UIColor(hex: "e05e71"), dark: UIColor(hex: "e05e71"))
        case .dangerColorX:
            return UIColor.dynamic(light: .white, dark: .white)
        case .primaryColor:
            return UIColor.dynamic(light: UIColor(hex: "#41AD49"), dark: UIColor(hex: "#41AD49"))
        case .primaryColorX:
            return UIColor.dynamic(light: .white, dark: .white)
        case .secondaryColor:
            return UIColor.dynamic(light: UIColor(hex: "#262524"), dark: UIColor(hex: "#262524"))
        case .secondaryColorX:
            return UIColor.dynamic(light: .white, dark: .white)
        case .groupedCellColor:
            return UIColor.dynamic(light: .white, dark: UIColor(hex: "#2C2C2E"))
        case .groupedCellColorX:
            return UIColor.dynamic(light: UIColor(hex: "#262524"), dark: .white)
        case .inputColor:
            return UIColor.dynamic(light: .white, dark: UIColor(hex: "#2C2C2E"))
        case .inputColorX:
            return UIColor.dynamic(light: UIColor(hex: "#262524"), dark: .white)
        }
    }

}

public class ColorSet {

    public static let shared = ColorSet()

    private(set) public var appBackground = ColorKind.appBackground.color
    private(set) public var appContent    = ColorKind.appContent.color

    private(set) public var navColor  = ColorKind.navColor.color
    private(set) public var navColorX = ColorKind.navColorX.color

    private(set) public var accentColor   = ColorKind.accentColor.color

    private(set) public var borderColor   = ColorKind.borderColor.color

    private(set) public var textColor     = ColorKind.textColor.color
    private(set) public var secondaryTextColor = ColorKind.secondaryTextColor.color

    private(set) public var dangerColor   = ColorKind.dangerColor.color
    private(set) public var dangerColorX  = ColorKind.dangerColorX.color

    private(set) public var primaryColor  = ColorKind.primaryColor.color
    private(set) public var primaryColorX = ColorKind.primaryColorX.color

    private(set) public var secondaryColor  = ColorKind.secondaryColor.color
    private(set) public var secondaryColorX = ColorKind.secondaryColorX.color

    private(set) public var groupedCellColor  = ColorKind.groupedCellColor.color
    private(set) public var groupedCellColorX = ColorKind.groupedCellColorX.color

    private(set) public var inputColor  = ColorKind.inputColor.color
    private(set) public var inputColorX = ColorKind.inputColorX.color

    public func setColor(_ key: ColorKind, light: UIColor, dark: UIColor) {
        let color = UIColor.dynamic(light: light, dark: dark)
        switch key {
        case .appBackground:
            self.appBackground = color
        case .appContent:
            self.appContent = color
        case .navColor:
            self.navColor = color
        case .navColorX:
            self.navColorX = color
        case .accentColor:
            self.accentColor = color
        case .borderColor:
            self.borderColor = color
        case .textColor:
            self.textColor = color
        case .secondaryTextColor:
            self.secondaryTextColor = color
        case .dangerColor:
            self.dangerColor = color
        case .dangerColorX:
            self.dangerColorX = color
        case .primaryColor:
            self.primaryColor = color
        case .primaryColorX:
            self.primaryColorX = color
        case .secondaryColor:
            self.secondaryColor = color
        case .secondaryColorX:
            self.secondaryColorX = color
        case .groupedCellColor:
            self.groupedCellColor = color
        case .groupedCellColorX:
            self.groupedCellColorX = color
        case .inputColor:
            self.inputColor = color
        case .inputColorX:
            self.inputColorX = color
        }
    }

    public func setColor(_ key: ColorKind, _ value: UIColor) {
        setColor(key, light: value, dark: value)
    }

    public func setColors(_ colors: [ColorKind: (light: UIColor, dark: UIColor)]) {
        colors.forEach { (key, value) in
            setColor(key, light: value.light, dark: value.dark)
        }
    }

    public func setColors(_ colors: [ColorKind: UIColor]) {
        colors.forEach { (key, value) in
            setColor(key, value)
        }
    }

}

public extension UIColor {

    static var appBackground: UIColor { return ColorSet.shared.appBackground }
    static var appContent: UIColor    { return ColorSet.shared.appContent }

    static var navColor: UIColor  { return ColorSet.shared.navColor }
    static var navColorX: UIColor { return ColorSet.shared.navColorX }

    static var accentColor: UIColor { return ColorSet.shared.accentColor }

    static var borderColor: UIColor { return ColorSet.shared.borderColor }

    static var textColor: UIColor          { return ColorSet.shared.textColor }
    static var secondaryTextColor: UIColor { return ColorSet.shared.secondaryTextColor }

    static var dangerColor: UIColor  { return ColorSet.shared.dangerColor }
    static var dangerColorX: UIColor { return ColorSet.shared.dangerColorX }

    static var primaryColor: UIColor  { return ColorSet.shared.primaryColor }
    static var primaryColorX: UIColor { return ColorSet.shared.primaryColorX }

    static var secondaryColor: UIColor  { return ColorSet.shared.secondaryColor }
    static var secondaryColorX: UIColor { return ColorSet.shared.secondaryColorX }

    static var groupedCellColor: UIColor  { return ColorSet.shared.groupedCellColor }
    static var groupedCellColorX: UIColor { return ColorSet.shared.groupedCellColorX }

    static var inputColor: UIColor   { return ColorSet.shared.inputColor }
    static var inputColorX: UIColor  { return ColorSet.shared.inputColorX }

}
