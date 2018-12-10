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
        setupTapEvents()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = Colors.Background.value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false
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
        
        viewModel.isFormValid.subscribe { [weak self] (button) in
            guard let self = self else { return }
            if button.element ?? false {
                self.loginButton.backgroundColor = Colors.Accent.value
                self.loginButton.isEnabled = true
            } else {
                self.loginButton.backgroundColor = .lightGray
                self.loginButton.isEnabled = false
            }
        }.disposed(by: viewModel.disposeBag)
        
    }

    fileprivate func setupTapEvents() {
        loginButton.rx.tap
            .subscribe(onNext: {
                if Validation.isEmailValid(with: self.viewModel.email.value) {
                    self.gotoDashboard()
                } else {
                    AlertMessage.show(on: self, title: "Warning", message: "Invalid Email")
                }
            })
            .disposed(by: viewModel.disposeBag)
    }

    fileprivate func gotoDashboard() {
        if viewModel.isLoginValid() {
            //let layout = UICollectionViewFlowLayout()
            //let dashboardController = DashboardController(collectionViewLayout: layout)
            present(MainTabBarController(), animated: true, completion: nil)
            //self.navigationController?.pushViewController(MainTabBarController(), animated: true)
        } else {
            AlertMessage.show(on: self, title: "Warning", message: "Incorrect email or password")
        }
    }
}
