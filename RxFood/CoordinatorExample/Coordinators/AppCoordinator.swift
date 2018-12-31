//
//  AppCoordinator.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator {
    let window: UIWindow?

    let rootNavigation: UINavigationController = {
        let vc = UINavigationController()
        vc.isNavigationBarHidden = true
        return vc
    }()

    var showDashboard = false

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        window?.rootViewController = nil
        if !showDashboard {
            showLangingPage()
        } else {
            gotoDashboard()
        }
    }

    func showLangingPage() {
        let landingCoordinator = LandingCoordinator(navigation: rootNavigation)

        landingCoordinator.onFinish = { [unowned self] in
            print("Finished...")
            self.showDashboard = true
            self.start()
        }

        coordinate(to: landingCoordinator)
        window?.rootViewController = rootNavigation
    }

    func gotoDashboard() {
        let tabBarCoordinator = TabBarCoordinator(navigation: rootNavigation)
        coordinate(to: tabBarCoordinator)

//        let mainTabBar = TabBarController(navigation: rootNavigation)
//        window?.rootViewController = mainTabBar
    }
}
