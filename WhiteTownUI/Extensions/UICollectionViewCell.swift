//
//  UICollectionViewCell.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 03/10/2020.
//

import UIKit

public extension UICollectionViewCell {

//    static var identifier: String {
//        return String(describing: self)
//    }

    static func dequeue<T: UICollectionViewCell>(from collectionView: UICollectionView, for indexPath: IndexPath) -> T {
        let result = collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        return result as? T ?? T()
    }
}

public extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let result = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        return result as? T ?? T()
    }
}
