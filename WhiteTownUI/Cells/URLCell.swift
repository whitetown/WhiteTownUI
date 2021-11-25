//
//  URLCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 05/11/2020.
//

import UIKit

open class URLCell: WTCell {

    public var onURL: ((URL)->Void)?

    internal var normal: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.secondaryTextColor,
        ]

    internal var link: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.thick.rawValue,
        ]

    internal var value = ""
    internal var urls  = [String: URL?]()
    internal var alignment: NSTextAlignment = .center

    internal let textView = UITextView()

    open override func initialize() {

        self.backgroundColor = .clear
        self.selectionStyle = .none

        self.textView.backgroundColor = .clear
        self.textView.linkTextAttributes = self.link
        self.textView.isEditable = false
        self.textView.isSelectable = true
        self.textView.isScrollEnabled = false
        self.textView.dataDetectorTypes = .all
        self.textView.delegate = self

        self.contentView.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.leading.equalTo(self.readableContentGuide)
            make.bottom.equalToSuperview().priority(.low)
        }
    }

    public func set(value: String, urls: [String: URL?]) {
        self.value = value
        self.urls  = urls
        updateContent()
    }

    func updateContent() {

        let ats = NSMutableAttributedString(string: self.value)

        let full_range = NSRange(location: 0, length: ats.string.count)
        ats.addAttributes(self.normal, range: full_range)

        self.urls.forEach { (key, value) in
            let t_range = ats.mutableString.range(of: key)
            ats.addAttributes([
                NSAttributedString.Key.link: value as Any,
                ], range: t_range)
        }

        self.textView.attributedText = ats
        self.textView.textAlignment = self.alignment
        self.textView.layoutIfNeeded()
    }
}

extension URLCell: UITextViewDelegate {

    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        self.onURL?(URL)
        return false
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
    }
}

