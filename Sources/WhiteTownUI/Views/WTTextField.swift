//
//  WTTextField.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 23/07/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

open class WTTextField: UITextField {

    public var onWillChange: ((String, NSRange, String)->Bool)?
    public var onTextChange: ((String)->Void)?
    public var onFocus: (()->Void)?
    public var onBlur:  ((String)->Void)?
    public var onEnter: (()->Void)?

    public var inactiveColor: UIColor? = UIColor.borderColor
    public var activeColor: UIColor?   = UIColor.accentColor
    public var placeholderColor: UIColor?

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)

    open override var placeholder: String? {
        didSet {
            if let placeholderColor = self.placeholderColor, let placeholder = self.placeholder {
                self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                attributes: [.foregroundColor: placeholderColor])
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    open func initialize() {

        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = self.inactiveColor?.cgColor

        self.delegate = self
        self.clearButtonMode = .whileEditing

        self.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)

        if UIDevice.current.userInterfaceIdiom == .pad {
            self.inputAssistantItem.leadingBarButtonGroups = []
            self.inputAssistantItem.trailingBarButtonGroups = []
        }

    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    @objc func didChange(_ textField: UITextField) {
        self.onTextChange?(self.text ?? String.empty)
    }

}

extension WTTextField: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = self.activeColor?.cgColor
        self.onFocus?()
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = self.inactiveColor?.cgColor
        self.onBlur?(textField.text ?? String.empty)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.onWillChange?(textField.text ?? "", range, string) ?? true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onEnter?()
        return true
    }

}
