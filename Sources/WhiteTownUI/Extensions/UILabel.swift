//
//  UILabel.swift
//  SynchroSnap
//
//  Created by Sergey Chehuta on 16/02/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

public extension UILabel {

    convenience init(style: UIFont.Weight = .regular,
                            size:  CGFloat = 15,
                            color: UIColor = UIColor.black,
                            align: NSTextAlignment = .left,
                            lines: Int = 1,
                            scale: CGFloat = 1
                            ) {
            self.init()

            self.font = UIFont.systemFont(ofSize: size, weight: style)
            self.textColor = color
            self.textAlignment = align
            self.numberOfLines = lines
            //self.lineBreakMode = lines == 1 ? .byTruncatingTail : .byWordWrapping
            self.minimumScaleFactor = scale
            self.adjustsFontSizeToFitWidth = scale != 1
    }

    convenience init(font:  UIFont,
                            color: UIColor = UIColor.black,
                            align: NSTextAlignment = .left,
                            lines: Int = 1,
                            scale: CGFloat = 1
                            ) {
            self.init()

            self.font = font
            self.textColor = color
            self.textAlignment = align
            self.numberOfLines = lines
            //self.lineBreakMode = lines == 1 ? .byTruncatingTail : .byWordWrapping
            self.minimumScaleFactor = scale
            self.adjustsFontSizeToFitWidth = scale != 1
    }

    func setTextAnimated(_ text: String?) {
        UIView.transition(with: self,
             duration: 0.3,
              options: .transitionCrossDissolve,
           animations: {
               self.text = text
        }, completion: nil)
    }

    func textHeight(for width: CGFloat) -> CGFloat {

        if self.text?.count == 0 { return 0 }

        let maximumLabelSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        var result: CGFloat = 0

        if self.attributedText?.length ?? 0 > 0 {
            let paragraphRect = self.attributedText?.boundingRect(with: maximumLabelSize,
                                         options: [ .usesLineFragmentOrigin, .usesFontLeading ],
                                         context: nil)
            result = paragraphRect?.size.height ?? 0
        } else {
            result = self.text?.height(withConstrainedWidth: width, font: self.font) ?? 0
        }

        return result
    }
    
}

extension UILabel {

    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}
