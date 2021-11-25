//
//  LogsViewController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 12/11/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

open class LogsViewController: BaseViewController {

    public let tv = UITextView()

    private(set) public var share: UIBarButtonItem?

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Logs".unlocalized

        self.tv.textColor = UIColor.textColor
        self.tv.backgroundColor = .clear
        self.tv.isEditable = false
        self.tv.dataDetectorTypes = .all
        self.tv.font = UIFont(name: "Courier", size: 14)
        self.tv.alwaysBounceVertical = true
        self.view.addSubview(self.tv)
        self.tv.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearLog))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshLog))
        let share   = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareLog))

        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItems  = [trash]
        self.navigationItem.rightBarButtonItems = [refresh, share]
        self.share = share
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshLog()
    }

    public func loadFile() {
        if let url = WTLog.filename {
            let txt = try? String(contentsOf: url, encoding: String.Encoding.utf8)
            self.tv.text = txt
        }
    }

    @objc public func clearLog() {
        WTLog.shared.clear()
        self.tv.text = ""
    }

    @objc public func refreshLog() {
        loadFile()
        self.tv.scrollRangeToVisible(NSRange(location: self.tv.text?.count ?? 0, length: 0))
    }

    @objc func shareLog() {
        if let url = WTLog.filename {

            let items: [Any] = [url]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)

            ac.popoverPresentationController?.barButtonItem = self.share
            ac.popoverPresentationController?.sourceRect = self.share?.accessibilityFrame ?? .zero
            ac.popoverPresentationController?.sourceView = self.view

            self.present(ac, animated: true)
        }
    }

}

