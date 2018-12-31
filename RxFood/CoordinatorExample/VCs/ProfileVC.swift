//
//  ProfileVC.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    let logout: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .yellow
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "Profile"
        setupView()
    }

    fileprivate func setupView() {
        view.addSubview(logout)
        logout.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 60, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 60, right: nil, paddingRight: 0, width: 100, height: 50)
    }
}
