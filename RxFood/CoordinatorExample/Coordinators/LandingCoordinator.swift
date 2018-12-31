//
//  LangingCoordinator.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift

class LandingCoordinator: BaseCoordinator {
    let navigationController: UINavigationController

    init(navigation: UINavigationController) {
        navigationController = navigation
    }

    override func start() {
        let chooseVC = ChooseVC()

        chooseVC.toRedVC.subscribe(onNext: { [unowned self] in
            print("Goto red")
            self.gotoRedVC()
        })
        .disposed(by: disposeBag)

        chooseVC.toYellowVC.subscribe(onNext: { [unowned self] in
            print("Goto Yellow")
            self.gotoYellowVC()
        })
        .disposed(by: disposeBag)

        navigationController.setViewControllers([chooseVC], animated: true)
    }
}

extension LandingCoordinator {
    func gotoRedVC() {
        let redVC = RedVC()

        redVC.dashboardSubject.subscribe(onNext: { [unowned self] in
            print("Goto dashboard")
            self.finish()
        })
        .disposed(by: disposeBag)

        navigationController.pushViewController(redVC, animated: true)
    }

    func gotoYellowVC() {
        let yellowVC = YellowVC()
        navigationController.pushViewController(yellowVC, animated: true)
    }
}
