//
//  InputToolbar.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 02/05/2021.
//

import UIKit

public enum InputToolbarButton {
    case done
    case cancel
    case back
    case forward
    case flexspace
    case custom(UIBarButtonItem)
}

public protocol InputToolbarDelegate: AnyObject {
    func onButtonTap(sender: UIBarButtonItem, type: InputToolbarButton)
}

open class InputToolbar: UIToolbar {

    weak var inputDelegate: InputToolbarDelegate?

    override public init(frame: CGRect) {
        if frame.size.height > 0 {
            super.init(frame: frame)
        } else {
            super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        }
        initialize()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func initialize() {
        self.barStyle = UIBarStyle.default
        self.isTranslucent = true
        self.tintColor = UIColor.primaryColor
        self.sizeToFit()
        self.isUserInteractionEnabled = true
    }

    public func addButtons(left: [InputToolbarButton] = [], right: [InputToolbarButton] = [.done], delegate: InputToolbarDelegate) {

        self.inputDelegate = delegate

        var items = [UIBarButtonItem]()

        left.forEach { item in
            items.append(addButton(item))
        }
        items.append(addButton(.flexspace))
        right.forEach { item in
            items.append(addButton(item))
        }

        self.setItems(items, animated: false)
    }

    func addButton(_ item: InputToolbarButton) -> UIBarButtonItem {
        switch item {
        case .done:
            return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneTap))
        case .cancel:
            return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelTap))
        case .back:
            return UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(onBackTap))
        case .forward:
            return UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(onForwardTap))
        case .flexspace:
            return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        case .custom(let btn):
            if (btn.target == nil) { btn.target = self }
            if (btn.action == nil) { btn.action = #selector(onCustomTap(_:)) }
            return btn
        }
    }

    @objc func onDoneTap(_ sender: UIBarButtonItem) {
        self.inputDelegate?.onButtonTap(sender: sender, type: .done)
    }

    @objc func onCancelTap(_ sender: UIBarButtonItem) {
        self.inputDelegate?.onButtonTap(sender: sender, type: .cancel)
    }

    @objc func onBackTap(_ sender: UIBarButtonItem) {
        self.inputDelegate?.onButtonTap(sender: sender, type: .back)
    }

    @objc func onForwardTap(_ sender: UIBarButtonItem) {
        self.inputDelegate?.onButtonTap(sender: sender, type: .forward)
    }

    @objc func onCustomTap(_ sender: UIBarButtonItem) {
        self.inputDelegate?.onButtonTap(sender: sender, type: .custom(sender))
    }

}

public extension UITextField {
    @discardableResult
    func addToolbar(left: [InputToolbarButton] = [], right: [InputToolbarButton] = [.done], delegate: InputToolbarDelegate) -> InputToolbar {
        let toolbar = InputToolbar()
        toolbar.addButtons(left: left, right: right, delegate: delegate)
        self.inputAccessoryView = toolbar
        return toolbar
    }
}

public extension UITextView {
    @discardableResult
    func addToolbar(left: [InputToolbarButton] = [], right: [InputToolbarButton] = [.done], delegate: InputToolbarDelegate) -> InputToolbar {
        let toolbar = InputToolbar()
        toolbar.addButtons(left: left, right: right, delegate: delegate)
        self.inputAccessoryView = toolbar
        return toolbar
    }
}

public extension InputCell {
    @discardableResult
    func addToolbar(left: [InputToolbarButton] = [], right: [InputToolbarButton] = [.done], delegate: InputToolbarDelegate) -> InputToolbar {
        return self.textField.addToolbar(left: left, right: right, delegate: delegate)
    }
}

public extension FreeCell {
    @discardableResult
    func addToolbar(left: [InputToolbarButton] = [], right: [InputToolbarButton] = [.done], delegate: InputToolbarDelegate) -> InputToolbar {
        return self.textView.addToolbar(left: left, right: right, delegate: delegate)
    }
}
