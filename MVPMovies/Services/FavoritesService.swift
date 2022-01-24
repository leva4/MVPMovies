//
//  FavoritesService.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

protocol FavoritesServiceProtocol {
    func getFavorites() -> [Media]
    func addToFavorites(_ media: Media)
    func removeFromFavorites(_ media: Media)
    func isInFavorites(_ media: Media) -> Bool
}

class FavoritesService: FavoritesServiceProtocol {

    func getFavorites() -> [Media] {
        return Array(LocalStorage.favoriteMedia)
    }

    func addToFavorites(_ media: Media) {
        LocalStorage.favoriteMedia.insert(media)
    }

    func removeFromFavorites(_ media: Media) {
        LocalStorage.favoriteMedia.remove(media)
    }

    func isInFavorites(_ media: Media) -> Bool {
        return LocalStorage.favoriteMedia.contains(media)
    }
}
