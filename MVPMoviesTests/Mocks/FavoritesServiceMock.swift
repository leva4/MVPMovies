//
//  FavoritesServiceMock.swift
//  MVPMoviesTests
//
//  Created by Kresimir Levarda on 24.01.2022..
//

@testable import MVPMovies

class FavoritesServiceMock: FavoritesServiceProtocol {
    var favorites = [Media]()

    func getFavorites() -> [Media] {
        return favorites
    }

    func addToFavorites(_ media: Media) {
        favorites.append(media)
    }

    func removeFromFavorites(_ media: Media) {
        favorites.removeAll(where: { $0 == media })
    }

    func isInFavorites(_ media: Media) -> Bool {
        return favorites.contains(where: { $0 == media })
    }
}
