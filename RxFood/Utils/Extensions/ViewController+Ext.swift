//
//  ViewController+Ext.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showHud(isTrue: Bool) {
        if isTrue {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

