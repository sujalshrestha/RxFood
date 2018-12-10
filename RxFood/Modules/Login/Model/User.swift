//
//  User.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

struct User {
    let email: String
    let firstname: String
    let lastname: String
    let password: String
    let userId: Int
}

struct UserManager {
    private var users = [User]()

    init() {
        let user1 = User(email: "abc@abc.com", firstname: "Abc", lastname: "Abc", password: "123456", userId: 1001)
        let user2 = User(email: "random@random.com", firstname: "Random", lastname: "Abc", password: "123456", userId: 1002)
        let user3 = User(email: "aaa@aaa.com", firstname: "AAA", lastname: "ADS", password: "123456", userId: 1003)
        let user4 = User(email: "bbb@bbb.com", firstname: "BBB", lastname: "BBB", password: "123456", userId: 1004)

        users = [user1, user2, user3, user4]
    }

    func getUsers() -> [User] {
        return users
    }
}
