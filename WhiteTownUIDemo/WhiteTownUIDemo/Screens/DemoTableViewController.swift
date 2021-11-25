//
//  DemoTableViewController.swift
//  WhiteTownUIDemo
//
//  Created by Sergey Chehuta on 21/04/2021.
//

import UIKit
import WhiteTownUI

class DemoTableViewController: BaseTableViewController {

    private let rows = DemoRows.allCases

    deinit {
        unsubscribeFromKeyboardEvents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Demo table".unlocalized
        initializeTableView()
        subscribeToKeyboardEvents()
    }

    override func onKeyboardChange(_ height: CGFloat) {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }

}

private extension DemoTableViewController {

    func initializeTableView() {
        self.tableView.registerCell(InputCell.self)
        self.tableView.registerCell(EmailAddressCell.self)
        self.tableView.registerCell(PasswordCell.self)
        self.tableView.registerCell(FreeCell.self)
        self.tableView.registerCell(ButtonCell.self)
        self.tableView.registerCell(HexCell.self)
        self.tableView.registerCell(URLCell.self)
        self.tableView.registerCell(Value1Cell.self)
    }

    func onSubmit() {
        self.view.endEditing(true)
        print("Submit")
        WTLog.shared.log("Submit")
    }

}

extension DemoTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var welf = self

        switch self.rows[indexPath.row] {
        case .email:
            let cell: EmailAddressCell = tableView.dequeue(for: indexPath)
            cell.addToolbar(left: [
                                .back,
                                .forward,
                                .custom(UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil))],
                            delegate: self)
            cell.onTextChange = { text in
                print(text)
                WTLog.shared.log(text)
            }
            return cell
        case .password:
            let cell: PasswordCell = tableView.dequeue(for: indexPath)
            cell.onTextChange = { text in
                print(text)
                WTLog.shared.log(text)
            }
            return cell
        case .text:
            let cell: InputCell = tableView.dequeue(for: indexPath)
            cell.title = "One line text".unlocalized
            cell.onTextChange = { text in
                print(text)
                WTLog.shared.log(text)
            }
            return cell
        case .longtext:
            let cell: FreeCell = tableView.dequeue(for: indexPath)
            cell.title = "Multiline text".unlocalized
            cell.onTextChange = { text in
                print(text)
                WTLog.shared.log(text)
            }
            return cell
        case .hex:
            let cell: HexCell = tableView.dequeue(for: indexPath)
            cell.title = "Hex keyboard".unlocalized
            cell.onTextChange = { text in
                print(text)
                WTLog.shared.log(text)
            }
            return cell
        case .url:
            let cell: URLCell = tableView.dequeue(for: indexPath)
            cell.set(value: "I accept terms and privacy",
                     urls: [
                        "terms": URL(string: "https://whitetown.com/map"),
                        "privacy": URL(string: "https://whitetown.com/privacy"),
                     ])
            cell.onURL = { url in
                welf?.openURLinsideApp(url: url)
                WTLog.shared.log(url.absoluteString)
            }
            return cell
        case .keyvalue:
            let cell: Value1Cell = tableView.dequeue(for: indexPath)
            cell.textLabel?.text = "Key"
            cell.detailTextLabel?.text = "Value"
            return cell
        case .button:
            let cell: ButtonCell = tableView.dequeue(for: indexPath)
            cell.submit()
            cell.onTap = {
                welf?.onSubmit()
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension DemoTableViewController: InputToolbarDelegate {
    func onButtonTap(sender: UIBarButtonItem, type: InputToolbarButton) {
        switch type {
        case .done:
            self.view.endEditing(true)
        default:
            break
        }
    }
}


private enum DemoRows: CaseIterable {
    case email
    case password
    case text
    case longtext
    case hex
    case url
    case keyvalue
    case button
}

extension ButtonCell {

    func submit() {
        self.button.setTitle("Submit".unlocalized, for: .normal)
        self.button.primary()
    }

}
