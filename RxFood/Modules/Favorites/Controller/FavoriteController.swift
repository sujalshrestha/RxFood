//
//  FavoriteController.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class FavoriteController: UITableViewController {

    let tableId = "tableId"
    let viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchFavorties()
    }

    fileprivate func setupView() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableId)
        tableView.dataSource = nil
    }

    fileprivate func setupRx() {
        viewModel.foodData.bind(to: tableView.rx.items(cellIdentifier: tableId, cellType: UITableViewCell.self)) { index, food, cell in
            cell.textLabel?.text = food.title
        }
        .disposed(by: viewModel.disposeBag)

        tableView.rx
            .itemDeleted
            .subscribe { [weak self] indexValue in
                guard let self = self else { return }
                self.viewModel.deleteFavorite(at: indexValue.element?.row ?? 0)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
