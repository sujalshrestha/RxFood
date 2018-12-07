//
//  DashboardController.swift
//  RxFood
//
//  Created by Hira on 12/7/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import MBProgressHUD

class DashboardController: UICollectionViewController {

    let cellId = "cellId"
    let service = MoyaProvider<FoodsService>()
    let disposebag = DisposeBag()
    let apiClient = ApiClient()
    let viewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
        viewModel.fetchData()
    }

    fileprivate func setupView() {
        navigationItem.title = "Home"
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: "DashboardCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = nil
    }

    fileprivate func setupRx() {

        viewModel.showHud.subscribe(onNext: { [weak self] hud in
            guard let self = self else { return }
            self.showHud(isTrue: hud)
        })
        .disposed(by: viewModel.disposeBag)

        viewModel.foodData.bind(to: collectionView.rx.items(cellIdentifier: cellId, cellType: DashboardCell.self)) { index, food, cell in
            cell.food = food
        }
        .disposed(by: viewModel.disposeBag)
    }

}

extension DashboardController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 14
        return CGSize(width: width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

}