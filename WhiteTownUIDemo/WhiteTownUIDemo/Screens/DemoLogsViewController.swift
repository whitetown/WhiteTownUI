//
//  DemoLogsViewController.swift
//  WhiteTownUIDemo
//
//  Created by Sergey Chehuta on 21/04/2021.
//

import UIKit
import WhiteTownUI

class DemoLogsViewController: LogsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Demo logs".unlocalized
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        refreshLog()
//    }

}
