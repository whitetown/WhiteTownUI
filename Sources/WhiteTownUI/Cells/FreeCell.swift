//
//  FreeCell.swift
//  installapp
//
//  Created by Sergey Chehuta on 06/12/2020.
//

import UIKit

open class FreeCell: WTCell {

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
            self.textView.text = self.value
        }
    }
    public var limit = 500
    public var onTextChange: ((String)->Void)?

    public let titleLabel  = UILabel(color: UIColor.textColor)
    public let textView = UITextView()
    public let delButton = WTButton()

    public var inactiveColor: UIColor? = UIColor.borderColor
    public var activeColor: UIColor?   = UIColor.accentColor

    open override func initialize() {

        self.backgroundColor = .clear
        self.selectionStyle = .none

        var insets = self.textView.textContainerInset
        insets.right = 32
        self.textView.textContainerInset = insets
        self.textView.layer.cornerRadius = 8
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = self.inactiveColor?.cgColor

        self.textView.font = UIFont(name: "Courier", size: 16)
        self.textView.backgroundColor = .clear
        self.textView.isEditable = true
        self.textView.isSelectable = true
        self.textView.isScrollEnabled = false
        self.textView.dataDetectorTypes = []
        self.textView.delegate = self
        self.textView.backgroundColor = UIColor.inputColor
        self.textView.textColor = UIColor.inputColorX
        self.textView.tintColor = UIColor.inputColorX

        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.leading.equalTo(self.readableContentGuide)
            make.height.equalTo(0)
        }

        self.contentView.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.trailing.leading.equalTo(self.readableContentGuide)
            make.bottom.equalToSuperview().inset(10).priority(.low)
            make.height.greaterThanOrEqualTo(120)
            make.height.lessThanOrEqualTo(500)
        }

        self.delButton.tintColor = UIColor.textColor
        if #available(iOS 13.0, *) {
            self.delButton.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        } else {
            self.delButton.setTitle("⊗", for: .normal)
        }
        self.contentView.addSubview(self.delButton)
        self.delButton.snp.makeConstraints{ (make) in
            make.bottom.equalTo(self.textView)
            make.trailing.equalTo(self.readableContentGuide)
            make.width.height.equalTo(44)
        }
        weak var welf = self
        self.delButton.onTap = {
            welf?.textView.text = nil
        }

    }

}

extension FreeCell: UITextViewDelegate {

    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.layer.borderColor = self.activeColor?.cgColor
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        self.textView.layer.borderColor = self.inactiveColor?.cgColor
    }

    open func textViewDidChange(_ textView: UITextView) {
        self.onTextChange?(textView.text)
    }

    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= self.limit
    }

}
