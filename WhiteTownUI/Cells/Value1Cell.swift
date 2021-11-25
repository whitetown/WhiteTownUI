//
//  Value1Cell.swift
//  installapp
//
//  Created by Sergey Chehuta on 03/03/2021.
//  Copyright © 2021 WhiteTown. All rights reserved.
//

import UIKit

open class Value1Cell: UITableViewCell {

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    open func initialize() {

    }

}
