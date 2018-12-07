//
//  FoodService.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import Moya

enum FoodsService {
    case food
}

extension FoodsService: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.mocky.io/v2/")!
    }

    var path: String {
        switch self {
        case .food: return "5c0a2aab3500005700a85f94"
        }
    }

    var method: Moya.Method {
        switch self {
        case .food: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

}
