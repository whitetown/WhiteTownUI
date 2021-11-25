//
//  WTCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 03/10/2020.
//

import UIKit

open class WTCell: UITableViewCell {

    public var isSeparatorHidden = false {
        didSet {
            setNeedsLayout()
        }
    }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset = UIEdgeInsets(top: 0, left: isSeparatorHidden ? self.width : self.layoutMargins.right, bottom: 0, right: 0)
    }

}
