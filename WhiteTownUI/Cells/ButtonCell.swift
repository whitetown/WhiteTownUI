//
//  ButtonCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

open class ButtonCell: WTCell {

    public var isEnabled = true {
        didSet {
            self.button.isEnabled = self.isEnabled
        }
    }

    public var onTap: (()->Void)?

    public let button = WTButton()

    open override func initialize() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.isSeparatorHidden = true

        self.contentView.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalTo(self.contentView.readableContentGuide)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(5).priority(.low)
        }
        self.button.onTap = { [weak self] in
            self?.onTap?()
        }
    }

//    open override func layoutSubviews() {
//        super.layoutSubviews()
//        self.separatorInset = UIEdgeInsets(top: 0, left: self.width, bottom: 0, right: 0)
//    }

}
