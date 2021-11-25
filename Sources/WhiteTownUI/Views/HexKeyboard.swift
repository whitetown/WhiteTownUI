//
//  HexKeyboard.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 06/12/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

public class HexButton: WTButton {
    var hexCharacter: String = ""
}

public class HexKeyboard: WTView {

    public var target: UIKeyInput?

    public var onDismiss: (()->Void)?

    var hexadecimalButtons: [HexButton] = ["0","7","8","9","4","5","6","1","2","3","A","B","C","D","E","F"].map {
        let button = HexButton()
        button.hexCharacter = $0
        button.setTitle("\($0)", for: .normal)
        button.bgColor = UIColor.keyboardButtonColor
        button.fgColor = UIColor.keyboardTextColor
        button.addTarget(self, action: #selector(didTapHexButton(_:)), for: .touchUpInside)
        return button
    }

    var deleteButton: WTButton = {
        let button = WTButton()
        button.setTitle("⌫", for: .normal)
        button.bgColor = UIColor.keyboardButtonColor2
        button.fgColor = UIColor.keyboardTextColor
        button.accessibilityLabel = "Delete"
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()

    var okButton: WTButton = {
        let button = WTButton()
        button.setTitle("OK", for: .normal)
        button.bgColor = UIColor.keyboardButtonColor2
        button.fgColor = UIColor.keyboardTextColor
        button.accessibilityLabel = "OK"
        button.addTarget(self, action: #selector(didTapOKButton(_:)), for: .touchUpInside)
        return button
    }()

    var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing      = 10
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()

    open override func initialize() {
        configure()
    }

}

extension HexKeyboard {
    @objc func didTapHexButton(_ sender: HexButton) {
        self.target?.insertText("\(sender.hexCharacter)")
    }

    @objc func didTapDeleteButton(_ sender: HexButton) {
        self.target?.deleteBackward()
    }

    @objc func didTapOKButton(_ sender: HexButton) {
        self.onDismiss?()
    }
}

private extension HexKeyboard {

    func configure() {
        self.backgroundColor = UIColor.keyboardBackground
        autoresizingMask     = [.flexibleWidth, .flexibleHeight]
        buildKeyboard()
    }

    func buildKeyboard() {
        //MARK: - Add main stackview to keyboard
        self.mainStack.frame = bounds
        addSubview(self.mainStack)

        //MARK: - Create stackviews
        let panel1         = createStackView(axis: .vertical)
        let panel2         = createStackView(axis: .vertical)
        let panel2Group    = createStackView(axis: .vertical)
        let panel2Controls = createStackView(axis: .horizontal, distribution : .fillProportionally)


        //MARK: - Create multiple stackviews for numbers
        for row in 0 ..< 3 {
            let panel1Numbers = createStackView(axis: .horizontal)
            panel1.addArrangedSubview(panel1Numbers)

            for column in 0 ..< 3 {
                panel1Numbers.addArrangedSubview(self.hexadecimalButtons[row * 3 + column + 1])
            }
        }

        //MARK: - Create multiple stackviews for letters
        for row in 0 ..< 2 {
            let panel2Letters = createStackView(axis: .horizontal)
            panel2Group.addArrangedSubview(panel2Letters)

            for column in 0 ..< 3 {
                panel2Letters.addArrangedSubview(self.hexadecimalButtons[9 + row * 3 + column + 1])
            }
        }

        //MARK: - Nest stackviews
        self.mainStack.addArrangedSubview(panel1)
        panel1.addArrangedSubview(self.hexadecimalButtons[0])
        self.mainStack.addArrangedSubview(panel2)
        panel2.addArrangedSubview(panel2Group)
        panel2.addArrangedSubview(panel2Controls)
        panel2Controls.addArrangedSubview(self.deleteButton)
        panel2Controls.addArrangedSubview(self.okButton)

        //MARK: - Constraint - sets okButton width to two times the width of the deleteButton plus 10 points for the space
        panel2Controls.addConstraint(NSLayoutConstraint(
                                        item       : self.okButton,
                                        attribute  : .width,
                                        relatedBy  : .equal,
                                        toItem     : self.deleteButton,
                                        attribute  : .width,
                                        multiplier : 2,
                                        constant   : 10))
    }

    func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis         = axis
        stackView.distribution = distribution
        stackView.spacing      = 10
        return stackView
    }
}

extension UIColor {

    static var keyboardBackground   = UIColor.dynamic(light: UIColor(hex: "#d6d8dd"), dark: UIColor(hex: "#313130"))
    static var keyboardButtonColor  = UIColor.dynamic(light: UIColor(hex: "#ffffff"), dark: UIColor(hex: "#6c6c6c"))
    static var keyboardButtonColor2 = UIColor.dynamic(light: UIColor(hex: "#b2b7c1"), dark: UIColor(hex: "#484848"))
    static var keyboardTextColor    = UIColor.dynamic(light: UIColor(hex: "#000000"), dark: UIColor(hex: "#ffffff"))

}
