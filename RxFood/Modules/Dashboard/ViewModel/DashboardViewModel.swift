//
//  DashboardViewModel.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct DashboardViewModel {
    let disposeBag = DisposeBag()
    let foodData = BehaviorRelay<[Food]>.init(value: [])
    let apiClient = ApiClient()
    let showHud = BehaviorRelay<Bool>.init(value: false)
    let isNetworkOk = BehaviorRelay<Bool>.init(value: true)
    let networkMessage = BehaviorRelay<String>.init(value: "")

    func fetchData() {
        showHud.accept(true)

        apiClient.getFoodData(disposeBag: disposeBag, completion: { (foods) in
            self.foodData.accept(foods.foods)
            self.showHud.accept(false)
        }, failure: { (error) in
            self.showHud.accept(false)
            print("E: ", error)
            self.networkMessage.accept(error)
            self.isNetworkOk.accept(false)
        })
    }

    func saveToFavorite(for index: Int) {
        let favoriteFood = foodData.value[index]

        let food = FavoritesFoodCoreData(context: PersistanceManager.shared.context)
        food.title = favoriteFood.title
        food.details = favoriteFood.description
        food.price = Int16(favoriteFood.price)
        food.imgaeUrl = favoriteFood.imageURL

        let savedUserId = UserDefaultManager.shared.getUserId()
        let user = PersistanceManager.shared.fetch(UsersCoreData.self)

        user.forEach { (userValues) in
            if userValues.userid == savedUserId {
                userValues.addToFoods(food)
                PersistanceManager.shared.save()
            }
        }
    }
}
