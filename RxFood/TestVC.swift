//
//  TestVC.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestVC: UIViewController {

    let redButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Red", for: .normal)
        btn.backgroundColor = .red
        return btn
    }()

    let disposeBag = DisposeBag()

    let redSubject = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(redButton)
        redButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 100, height: 50)

        setupRx()
    }

    func setupRx() {
        redButton.rx.tap.bind(to: redSubject).disposed(by: disposeBag)

        redSubject.subscribe(onNext: { _ in
            print(123)
        })
        .disposed(by: disposeBag)
    }
}
