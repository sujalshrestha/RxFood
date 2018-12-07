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
    let service = MoyaProvider<FoodsService>()

    func getFoodData(disposeBag: DisposeBag, completion: @escaping (FoodsModel) -> ()) {
        service.rx.request(.food).subscribe { (event) in
            switch event {
            case .success(let response):
                do {
                    let responseModel = try JSONDecoder().decode(FoodsModel.self, from: response.data)
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
