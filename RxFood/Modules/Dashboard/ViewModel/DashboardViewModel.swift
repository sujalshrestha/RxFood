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

    func fetchData() {
        showHud.accept(true)
        apiClient.getFoodData(disposeBag: disposeBag) { (foods) in
            self.foodData.accept(foods.foods)
            self.showHud.accept(false)
        }
    }
}
