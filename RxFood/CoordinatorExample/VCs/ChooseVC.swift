//
//  ChooseVC.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChooseVC: UIViewController {

    let redButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Red", for: .normal)
        btn.backgroundColor = .red
        return btn
    }()

    let yellowButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Yellow", for: .normal)
        btn.backgroundColor = .yellow
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()

    let disposeBag = DisposeBag()

    let toRedVC = PublishSubject<Void>()
    let toYellowVC = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupRx()
    }

    fileprivate func setupView() {
        view.addSubview(redButton)
        redButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 100, height: 50)

        view.addSubview(yellowButton)
        yellowButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, left: redButton.rightAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 100, height: 50)
    }

    fileprivate func setupRx() {
        redButton.rx.tap.bind(to: toRedVC).disposed(by: disposeBag)
        yellowButton.rx.tap.bind(to: toYellowVC).disposed(by: disposeBag)
    }
}
