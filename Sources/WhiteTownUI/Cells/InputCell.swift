//
//  InputCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

open class InputCell: WTCell {

    public let container   = UIView()
    public let titleLabel  = UILabel(size: 16, color: UIColor.secondaryTextColor)
    public let textField   = WTTextField()
    public let separator   = UIView()
    public let statusContainer = UIView()
    public let statusLabel = UILabel(color: UIColor.dangerColor, align: .center, lines: 0)
    public let button      = WTButton()

    public var title: String? {
        didSet {
            self.titleLabel.text = self.title
            var h: CGFloat = 0
            if let title = self.title, title.trimmed.count > 0 {
                h = 28
            }
            self.titleLabel.snp.updateConstraints { (make) in
                make.height.equalTo(h)
            }
        }
    }

    public var value: String? {
        didSet {
            self.textField.text = self.value
        }
    }

    public var mustValidate = false {
        didSet {
            if self.mustValidate { validate() } else { self.errorMessage = nil }
        }
    }

    public var onTextChange:   ((String)->Void)?
    public var onButtonTap:    (()->Void)?
    public var onLayoutChange: (()->Void)?
    public var onFocus:        ((UITableViewCell)->Void)?
    public var onEnter:        (()->Void)?

    public var errorMessage: String? = nil {
        didSet {
            self.statusLabel.text = self.errorMessage
            self.onLayoutChange?()
        }
    }
//
//    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        createControls()
//        initialize()
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    open override func awakeFromNib() {
//        super.awakeFromNib()
//        createControls()
//        initialize()
//    }

    private func createControls() {

        weak var welf = self

        self.backgroundColor = .clear
        self.selectionStyle = .none

        self.textField.clearButtonMode = .whileEditing
        self.textField.autocorrectionType = .no
        self.textField.onFocus = {
            welf?.textFieldOnFocus()
        }
        self.textField.onBlur = { text in
            //welf?.mustValidate = true
        }
        self.textField.onTextChange = { text in
            welf?.textFieldDidChange(text)
        }
        self.textField.onEnter = {
            welf?.onEnter?()
        }

        self.statusContainer.clipsToBounds = true

        self.contentView.addSubview(self.container)
        self.container.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.contentView.readableContentGuide)
        }

        self.container.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
        }

        self.container.addSubview(self.textField)
        self.textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(48)
        }

        self.button.snp.makeConstraints { (make) in
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        self.button.onTap = {
            welf?.onButtonTap?()
        }

//        self.textField.rightView = self.button
//        self.textField.rightViewMode = .always

        self.separator.isHidden = true
        self.container.addSubview(self.separator)
        self.separator.snp.makeConstraints { (make) in
            make.top.equalTo(self.textField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.onePixel())
        }

        self.container.addSubview(self.statusContainer)
        self.statusContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.separator.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(2).priority(.low)
        }

        self.statusContainer.addSubview(self.statusLabel)
        self.statusLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    open override func initialize() {
        createControls()

        self.separator.backgroundColor = UIColor.secondaryColor
        self.textField.backgroundColor = UIColor.inputColor
        self.textField.textColor = UIColor.inputColorX
        self.textField.tintColor = UIColor.inputColorX
        self.textField.placeholderColor = UIColor.inputColorX.withAlphaComponent(0.5)
        self.button.tintColor = UIColor.inputColorX
    }

    open func validate() {

    }

    private func textFieldDidChange(_ text: String) {
        if self.mustValidate { validate() }
        self.onTextChange?(text)
    }

    public func textFieldOnFocus() {
        onFocus?(self)
    }

    public func focus() {
        self.textField.becomeFirstResponder()
    }

}
