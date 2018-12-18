//
//  SearchModel.swift
//  RxFood
//
//  Created by Hira on 12/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

typealias Repo = [RepoElement]

struct RepoElement: Codable {
    let id: Int
    let name, fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
    }
}
