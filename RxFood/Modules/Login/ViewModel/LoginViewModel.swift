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
                isUserValid = true
            }
        }
        return isUserValid
    }
    
}
