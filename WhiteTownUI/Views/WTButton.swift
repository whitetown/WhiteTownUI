//
//  WTButton.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 14/02/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//


import UIKit

open class WTButton: UIButton {

    public var bgColor = UIColor.clear {
        didSet { self.backgroundColor = self.bgColor }
    }
    
    public var fgColor = UIColor.textColor {
        didSet {
            self.setTitleColor(self.fgColor, for: .normal)
            self.tintColor = self.fgColor
        }
    }
    
    public var onTap: (()->Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.5
        }
    }
    
    open func initialize() {
        
        self.backgroundColor = self.bgColor
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.setTitleColor(self.fgColor, for: .normal)
        
        self.layer.cornerRadius = 8
        
        self.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
        self.addTarget(self, action: #selector(btnDown), for: .touchDown)
        self.addTarget(self, action: #selector(btnDown), for: .touchDragEnter)
        self.addTarget(self, action: #selector(btnUp), for: .touchUpOutside)
        self.addTarget(self, action: #selector(btnUp), for: .touchDragExit)
    }

    @objc private func btnTap() {
        btnUp()
        self.onTap?()
    }
    
    @objc private func btnDown() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0.9
            self.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.99, 0.99, 1.0)
        }
    }
    
    @objc private func btnUp() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
            self.layer.transform = CATransform3DIdentity
        }
    }

}

open class TransparentButton: WTButton {
    
}
