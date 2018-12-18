//
//  SearchViewModel.swift
//  RxFood
//
//  Created by Hira on 12/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct SearchViewModel {
    let disposeBag = DisposeBag()
    let searchText = BehaviorRelay<String>.init(value: "")
    let apiClient = ApiClient()
    let repoData = BehaviorRelay<Repo>.init(value: [])

    func fetchData() {
        print("Fetching api: ", searchText.value)
        apiClient.getRepo(with: searchText.value, disposeBag: disposeBag) { (repo) in
            self.repoData.accept(repo)
        }
    }
}
