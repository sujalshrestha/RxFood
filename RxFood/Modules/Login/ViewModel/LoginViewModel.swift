//
//  LoginViewModel.swift
//  RxFood
//
//  Created by Sujal on 12/6/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    let email = BehaviorRelay<String>.init(value: "")
    let password = BehaviorRelay<String>.init(value: "")
    
    let isFormValid: Observable<Bool>
    let userData = BehaviorRelay<User?>.init(value: nil)

    let disposeBag = DisposeBag()
    
    init() {
        isFormValid = Observable.combineLatest(email.asObservable(), password.asObservable(), resultSelector: { (email, password) in
            return email.count > 5 && password.count > 5
        })
    }

    func isLoginValid() -> Bool {
        let userManager = UserManager()
        let users = userManager.getUsers()
        var isUserValid = false
        users.forEach { (user) in
            if email.value == user.email && password.value == user.password {
                userData.accept(user)
                self.saveUser(user: user)
                isUserValid = true
            }
        }
        return isUserValid
    }

    func saveUser(user: User) {
        UserDefaultManager.shared.saveUserId(with: user.userId)
        let person = UsersCoreData(context: PersistanceManager.shared.context)
        person.email = user.email
        person.firstname = user.firstname
        person.lastname = user.lastname
        person.userid = Int16(user.userId)
        PersistanceManager.shared.save()
    }

}
