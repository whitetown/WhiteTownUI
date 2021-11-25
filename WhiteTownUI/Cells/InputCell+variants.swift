//
//  InputCell+variants.swift
//  installapp
//
//  Created by Sergey Chehuta on 01/03/2021.
//  Copyright © 2021 WhiteTown. All rights reserved.
//

import UIKit

public extension InputCell {

    func next() {
        self.textField.returnKeyType = .next
    }

    func send() {
        self.textField.returnKeyType = .send
    }

}
