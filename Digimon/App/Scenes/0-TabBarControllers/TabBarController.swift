//
//  TabBarController.swift
//  Digimon
//
//  Created by Diggo Silva on 07/05/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        UITabBar.appearance().isTranslucent = false
        viewControllers = [createFeedNavigationController(), createFavoritesNavigationController()]
    }
    
    private func createFeedNavigationController() -> UINavigationController {
        let feedVC = FeedViewController()
        feedVC.tabBarItem = UITabBarItem(title: "Digimons", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"))
        return UINavigationController(rootViewController: feedVC)
    }
    
    private func createFavoritesNavigationController() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        return UINavigationController(rootViewController: favoritesVC)
    }
}
