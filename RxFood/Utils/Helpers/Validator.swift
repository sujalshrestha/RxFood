//
//  Validator.swift
//  RxFood
//
//  Created by Sjl on 12/20/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

protocol ValidateStrategy {
    func validate(_ text: String) -> Bool
}

struct LengthValidateStrategy: ValidateStrategy {

    var count: Int

    func validate(_ text: String) -> Bool {
        return text.count > count ? true : false
    }
}

struct EmailValidateStrategy: ValidateStrategy {
    func validate(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let emailString = text
        return emailTest.evaluate(with: emailString)
    }
}

struct Validator {
    let strategy: ValidateStrategy

    func isValid(_ text: String) -> Bool {
        return strategy.validate(text)
    }
}

