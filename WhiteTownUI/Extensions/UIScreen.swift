//
//  UIScreen.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

public extension UIScreen {

    static func onePixel() -> CGFloat {
        return 1 / UIScreen.main.scale
    }

}
