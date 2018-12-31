//
//  RedVC.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RedVC: UIViewController {

    let dashboardButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Dashboard", for: .normal)
        btn.backgroundColor = .green
        return btn
    }()

    let disposeBag = DisposeBag()

    let dashboardSubject = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        view.addSubview(dashboardButton)
        dashboardButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 100, height: 50)

        setupRx()
    }

    func setupRx() {
        dashboardButton.rx.tap.bind(to: dashboardSubject).disposed(by: disposeBag)
    }
}
