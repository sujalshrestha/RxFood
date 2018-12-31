//
//  MainTabBarController.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    //let navigation: UINavigationController
    let homeCoordinator = HomeCoordinator()
    let profileCoordinator = ProfileCoordinator()

//    init(navigation: UINavigationController) {
//        //self.navigation = navigation
//        homeCoordinator = HomeCoordinator()
//        profileCoordinator = ProfileCoordinator()
//        super.init(nibName: nil, bundle: nil)
//    }
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    fileprivate func setupViewControllers() {
        viewControllers = [generateNavigationController(for: homeCoordinator.navigationController, title: "Home"),
                           generateNavigationController(for: profileCoordinator.navigationController, title: "Profile"),
        ]
    }

    // MARK:- Helper Functions
    fileprivate func generateNavigationController(for vc: UIViewController, title: String) -> UIViewController {
        vc.tabBarItem.title = title
        vc.title = title
        return vc
    }
}
