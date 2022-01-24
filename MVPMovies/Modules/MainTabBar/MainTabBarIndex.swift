//
//  MainTabBarIndex.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit

enum MainTabBarTabIndex: Int {
    case favorites = 0
    case search = 1
    
    var image: UIImage? {
        let image: UIImage?
        
        switch self {
        case .favorites:
            image = UIImage(systemName: "star")
        case .search:
            image = UIImage(systemName: "magnifyingglass" )
        }
        
        return image
    }
    
    var selectedImage: UIImage? {
        let image: UIImage?
        let boldConfig = UIImage.SymbolConfiguration(weight: .heavy)
        switch self {
        case .favorites:
            image = UIImage(systemName: "star", withConfiguration: boldConfig)
        case .search:
            image = UIImage(systemName: "magnifyingglass", withConfiguration: boldConfig)
        }
        return image
    }
    
    var title: String? {
        switch self {
        case .favorites:
            return "Favorites"
        case .search:
            return "Search"
        }
    }
}
