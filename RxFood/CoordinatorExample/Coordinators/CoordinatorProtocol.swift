//
//  CoordinatorProtocol.swift
//  RxFood
//
//  Created by Sjl on 12/31/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    var disposeBag: DisposeBag { get set }
    var childCoordinators: [BaseCoordinator] { get set }
    var onRemove: (() -> Void)? { get set }
    var onFinish: (() -> Void)? { get set }

    func start()
    func addChildCoordinator(_ coordinator: BaseCoordinator)
    func coordinate(to coordinator: BaseCoordinator)
    func removeChildCoordinator(_ coordinator: BaseCoordinator)
    func removeAllChildCoordinators()
    func finish()
}

extension CoordinatorProtocol {
    mutating func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func coordinate(to coordinator: BaseCoordinator) {
        addChildCoordinator(coordinator)
//        coordinator.onRemove = { _ in
//            removeChildCoordinator(coordinator)
//        }
        coordinator.start()
    }

    mutating func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
            print("Child coordinator \(coordinator) removed.")
        } else {
            print("Couldn't remove \(coordinator) child.")
        }
    }

    mutating func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    func finish() {
        removeAllChildCoordinators()
        onRemove?()
        onFinish?()
    }
}
