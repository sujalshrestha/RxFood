//
//  DraggableVC.swift
//  RxFood
//
//  Created by Sjl on 12/24/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class DraggableVC: UIViewController {

    let clickButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Click", for: .normal)
        btn.backgroundColor = .green
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        clickButton.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
    }

    fileprivate func setupView() {
        view.backgroundColor = .blue
        navigationItem.title = "Draggable"

        view.addSubview(clickButton)
        clickButton.anchor(top: view.topAnchor, paddingTop: 100, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
    }

    @objc func handleClick() {
        let addVC = AddVC()
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }

}
