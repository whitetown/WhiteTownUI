//
//  SpacingCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

open class SpacingCell: UITableViewCell {

    public convenience init(height: CGFloat) {
        self.init()
        self.backgroundColor = .clear
        self.selectionStyle = .none

        let fake = UIView()
        self.contentView.addSubview(fake)
        fake.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}
