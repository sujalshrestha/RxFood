//
//  UserDefaults.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct UserDefaultManager {
    static let shared = UserDefaultManager()
    let defaults = UserDefaults.standard
    private init() {}

    func saveUserId(with id: Int) {
        defaults.set(id, forKey: "UserId")
    }

    func getUserId() -> Int {
        return defaults.integer(forKey: "UserId")
    }
}
