//
//  PasswordCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

open class PasswordCell: InputCell {

    public var showPassword = false {
        didSet {
            self.button.isSelected = self.showPassword
        }
    }

    open override func initialize() {
        super.initialize()

        self.contentView.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.centerY.trailing.equalTo(self.textField)
        }

        self.mustValidate = true

        self.textField.clearButtonMode = .never
        self.title = "Password".localized
        self.textField.placeholder = "password".localized
        self.textField.isSecureTextEntry = true
        #if DEBUG
        self.textField.textContentType = .oneTimeCode
        #else
        self.textField.textContentType = .password
        #endif

        if #available(iOS 13.0, *) {
            self.button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            self.button.setImage(UIImage(systemName: "eye"), for: .selected)
        }

        weak var welf = self
        self.onButtonTap = {
            welf?.updateStatus()
        }

    }

    private func updateStatus() {
        let text = self.textField.text ?? ""
        self.button.isSelected = !self.button.isSelected
        self.textField.isSecureTextEntry = !self.button.isSelected
        if self.textField.isSecureTextEntry == true {
            self.textField.becomeFirstResponder()
            self.textField.deleteBackward()
            self.textField.insertText(text)
        }
    }

    open override func validate() {

//        switch self.textField.text?.validatePassword {
//        case .short:
//            self.errorMessage = "password_short".localized
//        case .weak:
//            self.errorMessage = "password_weak".localized
//        default:
//            self.errorMessage = nil
//        }
    }
}
