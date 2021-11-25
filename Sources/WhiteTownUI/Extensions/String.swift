//
//  String.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 30/09/2020.
//

import UIKit

public extension String {

    #if DEBUG
    var unlocalized: String {
        return self
    }
    #else
    @available(*, deprecated, message: "You should not use unlocalized strings in release builds")
    var unlocalized: String {
        return self
    }
    #endif

    var localized: String {
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == "en" {
            return value
        }

        guard
            let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let bundle = Bundle(path: path)
            else { return value }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }

    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }


    func size(withConstrainedWidth width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [kCTFontAttributeName as NSAttributedString.Key: font],
                                            context: nil)
        return boundingBox.size
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        return ceil(size(withConstrainedWidth: width, font: font).height)
    }

    func width(withConstrainedWidth width: CGFloat = CGFloat.greatestFiniteMagnitude, font: UIFont) -> CGFloat {
        return ceil(size(withConstrainedWidth: width, font: font).width)
    }

}

public extension String {

    static let empty = ""
    static let space  = " "
    static let dash_in_space = " - "
    static let pipe_in_space = " | "
    static let spaceChar: Character  = " "
    static let plus  = "+"
    static let comma = ","
    static let hash = "#"
}

public extension String {

    func utf16Range(_ range: NSRange) -> String {

        let start = self.utf16.index(self.utf16.startIndex, offsetBy: range.location)
        let end   = self.utf16.index(start, offsetBy: range.length)

        return String(utf16[start ..< end]) ?? ""
    }
}

public extension String {

    var phoneNumber: String {
        let allowedCharset = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+"))
        return String(self.unicodeScalars.filter(allowedCharset.contains))
    }

    var phoneURL: URL? {
        if self.trimmed.count > 0 {
            return URL(string: "tel://" + self)
        }
        return nil
    }

    var validateEmail: String? {
        if self.count == 0 { return nil }

        let strong = NSPredicate(format: "SELF MATCHES %@ ", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        if  strong.evaluate(with: self) { return nil }

        return "Email is incorrect"
    }

    var validatePassword: PasswordStrength {

        if self.count == 0 { return .none }
        if self.count < 8  { return .short }

        let excellent = NSPredicate(format: "SELF MATCHES %@ ",
                                    "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z])(?=.*[0-9]).{8,}$")
        if  excellent.evaluate(with: self) { return .excellent }

        let strong = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$")
        if  strong.evaluate(with: self) { return .strong }

        return .weak
    }

}

public extension String {
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}

public enum PasswordStrength {
    case none
    case short
    case weak
    case strong
    case excellent
}

public extension String {

    var hexValue: UInt64? {
        let scanner = Scanner(string: self)
        var value: UInt64 = 0

        let hexIsFine = scanner.scanHexInt64(&value)
        return hexIsFine ? value : nil
    }
}
