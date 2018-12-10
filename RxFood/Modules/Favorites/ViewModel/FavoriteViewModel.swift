//
//  FavoriteViewModel.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct FavoriteViewModel {
    let disposeBag = DisposeBag()
    let foodData = BehaviorRelay<[Food]>.init(value: [])

    func fetchFavorties() {
        let user = PersistanceManager.shared.fetchWithPredicate(UsersCoreData.self, with: String(UserDefaultManager.shared.getUserId()))
        var currentFoodList = [Food]()
        user.forEach { (value) in
            let food = value.foods?.allObjects as? [FavoritesFoodCoreData]

            food?.forEach({ (foodValues) in
                currentFoodList.append(Food(title: foodValues.title ?? "", description: foodValues.details ?? "", price: Int(foodValues.price), imageURL: foodValues.imgaeUrl ?? ""))
            })
        }
        foodData.accept(currentFoodList)
    }

    func deleteFavorite(at index: Int) {
        let user = PersistanceManager.shared.fetchWithPredicate(UsersCoreData.self, with: String(UserDefaultManager.shared.getUserId()))

        user.forEach { (userValue) in
            let food = userValue.foods?.allObjects[index] as! FavoritesFoodCoreData
            PersistanceManager.shared.delete(food)
        }
        fetchFavorties()
    }
}
