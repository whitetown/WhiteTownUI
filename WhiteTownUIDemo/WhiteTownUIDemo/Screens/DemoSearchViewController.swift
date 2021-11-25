//
//  DemoSearchViewController.swift
//  WhiteTownUIDemo
//
//  Created by Sergey Chehuta on 21/04/2021.
//

import UIKit
import WhiteTownUI

class DemoSearchViewController: BaseSearchViewController {

    private let allItems = [
        "one",
        "two",
        "three",
        "four",
        "six",
        "seven",
        "eight",
        "nine",
        "ten",
        ]
    private var items = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Demo search".unlocalized
        initializeSearch()
        showAll()
    }

    override func performSearch(with text: String) {
        self.items = self.allItems.filter({ $0.lowercased().contains(text.lowercased()) })
    }

    override func showAll() {
        self.items = self.allItems
    }

}

extension DemoSearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        WTLog.shared.log("on Select \(self.items[indexPath.row])")
    }

}
