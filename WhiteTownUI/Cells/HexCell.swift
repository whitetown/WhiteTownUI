//
//  HexCell.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 17/03/2021.
//

import UIKit

open class HexCell: InputCell {

    let hexKeyboard = HexKeyboard(frame: CGRect(x: 0, y: 0, width: 320, height: 240))

    open override func initialize() {
        super.initialize()

        self.hexKeyboard.target = self.textField
        self.hexKeyboard.onDismiss = { [weak self] in
            self?.textField.resignFirstResponder()
        }

        self.textField.placeholder = "00000000"
        self.textField.inputView = self.hexKeyboard
        self.textField.reloadInputViews()
    }
}
