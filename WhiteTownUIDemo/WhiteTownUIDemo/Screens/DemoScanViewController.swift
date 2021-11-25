//
//  DemoScanViewController.swift
//  WhiteTownUIDemo
//
//  Created by Sergey Chehuta on 21/04/2021.
//

import UIKit
import WhiteTownUI

class DemoScanViewController: BaseScanController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Demo scan".unlocalized
    }

    override func processTheCode(_ code: String) {
        WTLog.shared.log("Scan code: [\(code)]")
    }


}
