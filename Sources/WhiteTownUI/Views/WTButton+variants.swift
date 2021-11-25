//
//  WTButton+variants.swift
//  installapp
//
//  Created by Sergey Chehuta on 02/03/2021.
//  Copyright © 2021 WhiteTown. All rights reserved.
//

import UIKit

public extension WTButton {

    func primary() {
        self.bgColor = UIColor.primaryColor
        self.fgColor = UIColor.primaryColorX
    }

    func secondary() {
        self.bgColor = UIColor.secondaryColor
        self.fgColor = UIColor.secondaryColorX
    }

    func primaryOutline() {
        self.bgColor = UIColor.clear
        self.fgColor = UIColor.primaryColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.primaryColor.cgColor
    }

}
