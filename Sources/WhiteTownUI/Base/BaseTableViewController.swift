//
//  BaseTableViewController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 30/09/2020.
//

import UIKit

open class BaseTableViewController: BaseViewController {

    public let tableView: UITableView

    public init(style: UITableView.Style = .plain) {
        self.tableView = UITableView(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        return nil
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        addTable()
    }

    func addTable() {
        if #available(iOS 13.0, *) {
            self.tableView.automaticallyAdjustsScrollIndicatorInsets = true
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(UITableViewCell.self)
        self.tableView.cellLayoutMarginsFollowReadableWidth = true
        self.tableView.tableFooterView = UIView()

        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.view.addSubview(self.tableView)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            self.view.endEditing(true)
        }
    }

    public func centerContent() {
        let extraSpace = (self.tableView.height - self.tableView.contentSize.height)/2
        self.tableView.contentInset = UIEdgeInsets(top: max(0, extraSpace/2),
                                                   left: 0,
                                                   bottom: self.keyboardHeight,
                                                   right: 0)
    }

}

extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

}
