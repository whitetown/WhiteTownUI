//
//  UISearchBar.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 02/10/2020.
//

import UIKit

public extension UISearchBar {

    func setIconColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let iv = self.searchTextField.leftView as? UIImageView
            iv?.image = iv?.image?.withRenderingMode(.alwaysTemplate)
            iv?.tintColor = color
        } else {

        }
    }

    func setTextColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            self.searchTextField.textColor = color
        } else {

        }
    }

    func setPlaceholder(_ value: String, color: UIColor) {
        if #available(iOS 13.0, *) {
            self.searchTextField.attributedPlaceholder = NSAttributedString(string: value,
                                                        attributes: [.foregroundColor: color.withAlphaComponent(0.5)])
        } else {

        }
    }
}
