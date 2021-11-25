//
//  BaseCollectionViewController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 06/10/2020.
//

import UIKit

open class BaseCollectionViewController: BaseViewController {

    let layout: UICollectionViewLayout
    let collectionView: UICollectionView

    static func defaultLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        return layout
    }

    init(layout: UICollectionViewLayout = BaseCollectionViewController.defaultLayout()) {
        self.layout = layout
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        addCollectionView()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    private func addCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.appContent

        self.collectionView.frame = self.view.bounds
        self.collectionView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.view.addSubview(self.collectionView)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            self.view.endEditing(true)
        }
    }

}

extension BaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.backgroundColor = [UIColor.red, UIColor.gray, UIColor.green, UIColor.yellow][indexPath.row%4]
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

}
