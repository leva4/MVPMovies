//
//  MainCoordinator.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift

class MainCoordinator {
    
    private var mainTabBarController: MainTabBarController?
    
    func start(in window: UIWindow) {
        mainTabBarController = MainTabBarController()
        let homeViewController = FavoritesViewController(viewModel: FavoritesViewModel())
        homeViewController.tabBarItem = createTabBarItem(for: .favorites)
        let searchViewController = SearchViewController(viewModel: SearchViewModel())
        searchViewController.tabBarItem = createTabBarItem(for: .search)
        
        mainTabBarController?.viewControllers = [
            homeViewController,
            searchViewController
        ]
 
        window.rootViewController = mainTabBarController
    }
}

func createTabBarItem(for index: MainTabBarTabIndex) -> UITabBarItem {
    let item = UITabBarItem(title: nil, image: nil, tag: index.rawValue)
    item.title = index.title
    item.image = index.image
    item.selectedImage = index.selectedImage
    item.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
    return item
}
