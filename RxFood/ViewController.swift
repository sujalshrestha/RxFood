//
//  ViewController.swift
//  RxFood
//
//  Created by Sujal on 12/6/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getFavorites()
    }

    fileprivate func getFavorites() {
        let user = PersistanceManager.shared.fetchWithPredicate(UsersCoreData.self, with: String(UserDefaultManager.shared.getUserId()))
        user.forEach { (value) in
            print(value.email ?? "")
            let food = value.foods?.allObjects as? [FavoritesFoodCoreData]

            food?.forEach({ (foodValues) in
                print("Foods: ", foodValues.title ?? "")
            })
        }
    }

}

