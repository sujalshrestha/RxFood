//
//  RepoService.swift
//  RxFood
//
//  Created by Hira on 12/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import Moya

enum RepoService {
    case users(repoName: String)
}

extension RepoService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/users/")!
    }

    var path: String {
        switch self {
        case .users(let repoName): return "\(repoName)/repos"
        }
    }

    var method: Moya.Method {
        switch self {
        case .users: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }

}
