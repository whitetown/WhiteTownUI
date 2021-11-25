//
//  UITableViewCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 01/10/2020.
//

import UIKit

public extension UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    static func dequeue<T: UITableViewCell>(from tableView: UITableView, for indexPath: IndexPath) -> T {
        let result = tableView.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        return result as? T ?? T()
    }

}

public extension UITableView {

    func registerCell<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let result = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        return result as? T ?? T()
    }
}
