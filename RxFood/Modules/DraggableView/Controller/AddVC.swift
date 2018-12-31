//
//  AddVC.swift
//  RxFood
//
//  Created by Sjl on 12/24/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class AddVC: UIViewController {

    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()

    let foregroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.alpha = 0.9
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Activities"
        label.backgroundColor = .yellow
        return label
    }()

    var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        view.addSubview(backView)
        backView.anchor(top: view.topAnchor, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 0, width: 0, height: 0)

        view.addSubview(foregroundView)
        foregroundView.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 0, width: 0, height: 0)
        heightConstraint = foregroundView.heightAnchor.constraint(equalToConstant: 550)
        heightConstraint?.isActive = true

        foregroundView.addSubview(titleLabel)
        titleLabel.anchor(top: foregroundView.topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, left: foregroundView.leftAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)

        setupGesture()
    }

    private var startPosition: CGPoint!
    private var originalHeight: CGFloat = 0

    fileprivate func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        foregroundView.addGestureRecognizer(pan)
    }

    @objc func handlePan(sender: UIPanGestureRecognizer) {

        switch sender.state {
        case .began:
            print("Panning....")

        case .changed:
            let translation = sender.translation(in: foregroundView)
            print(translation.y)
            foregroundView.transform = CGAffineTransform(translationX: 0, y: translation.y)

        case .ended:
            foregroundView.transform = .identity
            print("ended")

        default:
            return
        }


    }

}
