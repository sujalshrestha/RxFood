
//
//  ProfileVC.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift

class ProfileCoordinator: BaseCoordinator {
    let navigationController: UINavigationController

    init(navigation: UINavigationController = UINavigationController()) {
        navigationController = navigation
        super.init()
        coordinate(to: self)
    }

    override func start() {
        let profile = ProfileVC()
        navigationController.viewControllers = [profile]
    }
}
