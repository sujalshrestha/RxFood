//
//  BaseCoordinator.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift

class BaseCoordinator {
    let disposeBag = DisposeBag()
    private var childCoordinators: [BaseCoordinator] = []
    private var onRemove: (() -> Void)?
    var onFinish: (() -> Void)?

    func start() {
        print("Start method must be implemented")
    }

    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func coordinate(to coordinator: BaseCoordinator) {
        addChildCoordinator(coordinator)
        coordinator.onRemove = { [unowned self] in
            self.removeChildCoordinator(coordinator)
        }
        coordinator.start()
    }

    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
            print("Child coordinator \(coordinator) removed.")
        } else {
            print("Couldn't remove \(coordinator) child.")
        }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    func finish() {
        removeAllChildCoordinators()
        onRemove?()
        onFinish?()
    }

}

extension BaseCoordinator: Equatable {

    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }

}
