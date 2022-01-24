//
//  MainCoordinator.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift

class MainCoordinator: MainCoordinatorProtocol {
    private var mainTabBarController: MainTabBarController?
    
    func start(in window: UIWindow) {
        mainTabBarController = MainTabBarController()
        let homeViewController = FavoritesViewController(viewModel: FavoritesViewModel(coordinator: self))
        homeViewController.tabBarItem = createTabBarItem(for: .favorites)
        let searchViewController = SearchViewController(viewModel: SearchViewModel(coordinator: self))
        searchViewController.tabBarItem = createTabBarItem(for: .search)
        
        mainTabBarController?.viewControllers = [
            BaseNavigationController(rootViewController: homeViewController),
            BaseNavigationController(rootViewController: searchViewController)
        ]
 
        window.rootViewController = mainTabBarController
    }
}

extension MainCoordinator {
    func presentMediaDetails(for media: Media) {
        let mediaDetailsViewController = MediaDetailsViewController(viewModel: MediaDetailsViewModel(media))
        let mediaDetailsNavigationController = BaseNavigationController(rootViewController: mediaDetailsViewController)
        mainTabBarController?.present(mediaDetailsNavigationController, animated: true, completion: nil)
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
