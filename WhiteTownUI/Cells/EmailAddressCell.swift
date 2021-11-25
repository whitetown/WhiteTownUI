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

        self.title = "Login".unlocalized
        self.textField.placeholder = "example@whitetown.com".unlocalized
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


