//
//  DashboardCoordinator.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift

class DashboardCoordinator: BaseCoordinator {
    let navigationController: UINavigationController

    init(navigation: UINavigationController) {
        navigationController = navigation
    }

    override func start() {
        let dashboard = DashboardVC()
        navigationController.setViewControllers([dashboard], animated: true)
    }
}
