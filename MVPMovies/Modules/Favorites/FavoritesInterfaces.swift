//
//  FavoritesInterfaces.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift
import RxCocoa
import UIKit

extension FavoritesViewModel {
    struct Output {
        var favoriteMedia: Driver<[Media]>
    }
}

protocol FavoritesViewModelProtocol: BaseViewModel {
    func configure() -> FavoritesViewModel.Output
    
    func toMediaDetails(_ selectedMedia: Media)
}
