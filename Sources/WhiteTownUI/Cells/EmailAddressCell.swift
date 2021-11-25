//
//  EmailAddressCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

open class EmailAddressCell: InputCell {

    open override func initialize() {
        super.initialize()

        self.title = "Email".localized
        self.textField.placeholder = "example@whitetown.com".localized
        self.textField.keyboardType = .emailAddress
        self.textField.autocapitalizationType = .none
        self.textField.autocorrectionType = .no
        self.textField.textContentType = .username

        self.mustValidate = true
    }

    open override func validate() {
        //self.errorMessage = self.textField.text?.validateEmail
    }

}


