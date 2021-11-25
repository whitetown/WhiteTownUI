//
//  BaseSearchViewController.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 09/10/2020.
//

import UIKit

open class BaseSearchViewController: BaseTableViewController {

    public let search = UISearchController(searchResultsController: nil)
    private(set) public var inSearch = false {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

    }

    open func initializeSearch() {
        self.search.searchResultsUpdater = self
        self.navigationItem.searchController = self.search
        self.search.searchBar.delegate = self
        self.search.searchBar.setIconColor(UIColor.navColorX)
        self.search.searchBar.tintColor = UIColor.navColorX
        self.search.searchBar.setTextColor(UIColor.navColorX)
        self.search.obscuresBackgroundDuringPresentation = false
    }

    open func performSearch(with text: String) {

    }

    open func showAll() {

    }

}

extension BaseSearchViewController: UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            performSearch(with: text)
        } else {
            showAll()
        }
    }
}

extension BaseSearchViewController: UISearchBarDelegate {

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.inSearch = true
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.inSearch = false
    }
}
