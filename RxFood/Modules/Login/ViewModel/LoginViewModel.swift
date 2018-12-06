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
    
//    fileprivate func isEmailValid() -> Bool {
//        print("email: ", email.value.count)
//        return email.value.count > 5
//    }
//
//    fileprivate func isPasswordValid() -> Bool {
//        print("pw: ", password.value.count)
//        return password.value.count > 5
//    }
    
}
