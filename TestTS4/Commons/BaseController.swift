//
//  BaseController.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//

import UIKit
import SwiftMessages

class BaseController: UIViewController {
    var progress: ProgressViewCustom?
    var swiftMessage: SwiftMessageCustom?
    func setupView() {}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.swiftMessage = SwiftMessageCustom()
        progress = ProgressViewCustom(inView: self.view)
    }

    func showHUD() {
        progress?.startProgressView()
    }

    func hideHUD() {
        progress?.stopProgressView()
    }
  
    func showMessage(message: String, type: Theme) {
        self.swiftMessage?.showSwiftMessage(message: message, type: type)
    }
}
