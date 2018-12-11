//
//  AlertMessage.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

struct AlertMessage {
    static func show(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

    static func showWithCancel(on vc: UIViewController, title: String?, message: String, onOk: @escaping () -> Void, onCancel: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
            onOk()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            onCancel?()
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
