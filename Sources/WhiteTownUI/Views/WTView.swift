//
//  WTView.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 26/07/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit
import SnapKit

open class WTView: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    open func initialize() {

    }
}
