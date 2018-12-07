//
//  FoodsModel.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct FoodsModel: Codable {
    let foods: [Food]
}

struct Food: Codable {
    let title, description: String
    let price: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title, description, price
        case imageURL = "imageUrl"
    }
}
