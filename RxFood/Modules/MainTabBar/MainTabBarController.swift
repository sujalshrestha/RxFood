//
//  MainTabBarController.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    fileprivate func setupTabs() {
        let layout = UICollectionViewFlowLayout()
        let dashboard = UINavigationController(rootViewController: DashboardController(collectionViewLayout: layout))
        let dashboardItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "home_selected").withRenderingMode(.alwaysOriginal))
        dashboard.tabBarItem = dashboardItem


        let favorite = UINavigationController(rootViewController: FavoriteController())
        let favoriteItem = UITabBarItem(title: "Favorite", image: #imageLiteral(resourceName: "heart_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "heart_selected").withRenderingMode(.alwaysOriginal))
        favorite.tabBarItem = favoriteItem

        let collageBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "collage")
        let collage = UINavigationController(rootViewController: collageBoard)
        let collageItem = UITabBarItem(title: "Collage", image: #imageLiteral(resourceName: "album_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "album_selected").withRenderingMode(.alwaysOriginal))
        collage.tabBarItem = collageItem

        tabBar.tintColor = .black

        viewControllers = [dashboard, favorite, collage]
    }
}
