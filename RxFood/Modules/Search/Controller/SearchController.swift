//
//  SearchController.swift
//  RxFood
//
//  Created by Hira on 12/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchController: UITableViewController {

    let search = UISearchController(searchResultsController: nil)
    let viewModel = SearchViewModel()
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupRx()
    }

    fileprivate func setupTableView() {
        navigationItem.title = "Search"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = nil
        tableView.tableFooterView = UIView()
    }

    fileprivate func setupRx() {

        search.searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: viewModel.disposeBag)

        viewModel.searchText.subscribe(onNext: { [weak self] (searchText) in
            guard let self = self else { return }
            self.viewModel.fetchData()
        })
        .disposed(by: viewModel.disposeBag)

        viewModel.repoData.bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: UITableViewCell.self)) { index, repo, cell in
            cell.textLabel?.text = repo.name
            cell.detailTextLabel?.text = repo.name
        }
        .disposed(by: viewModel.disposeBag)

    }

    fileprivate func setupSearchBar() {
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Repos"
        navigationItem.searchController = search
        navigationController?.navigationBar.prefersLargeTitles = true
        search.searchBar.searchBarStyle = .prominent
        definesPresentationContext = true
    }

}

extension SearchController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
