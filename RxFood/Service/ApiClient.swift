//
//  ApiClient.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct ApiClient {
    let service = MoyaProvider<FoodsService>(manager: ServiceManager.sharedManager)
    let repoService = MoyaProvider<RepoService>(manager: ServiceManager.sharedManager)
    
    func getFoodData(disposeBag: DisposeBag, completion: @escaping (FoodsModel) -> (), failure: @escaping (String) -> ()) {
        service.rx.request(.food).subscribe { (event) in
            switch event {
            case .success(let response):
                do {
                    let responseModel = try JSONDecoder().decode(FoodsModel.self, from: response.data)
                    print("Response: ", responseModel)
                    completion(responseModel)
                } catch let error {
                    print("Error: ", error)
                    failure(error.localizedDescription)
                }

            case .error(let error):
                print("Error: ", error)
                failure(error.localizedDescription)
            }
        }
        .disposed(by: disposeBag)
    }

    func getRepo(with repoName:String, disposeBag: DisposeBag, completion: @escaping (Repo) -> ()) {
        repoService.rx.request(.users(repoName: repoName)).subscribe { (event) in
            switch event {
            case .success(let response):
                do {
                    let responseModel = try JSONDecoder().decode(Repo.self, from: response.data)
                    print("Response: ", responseModel)
                    completion(responseModel)
                } catch let error {
                    print("Error: ", error)
                }

            case .error(let error):
                print("Error: ", error)
            }
        }
        .disposed(by: disposeBag)

    }
}
