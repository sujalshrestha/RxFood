//
//  LoginController.swift
//  RxFood
//
//  Created by Sujal on 12/6/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.rgb(red: 250, green: 250, blue: 250)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupRx() {
        
        emailField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: viewModel.disposeBag)
        
        passwordField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.isFormValid.subscribe { (button) in
            if button.element ?? false {
                self.loginButton.backgroundColor = .green
                self.loginButton.isEnabled = true
            } else {
                self.loginButton.backgroundColor = .lightGray
                self.loginButton.isEnabled = false
            }
        }.disposed(by: viewModel.disposeBag)
        
    }
}
