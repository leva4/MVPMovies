//
//  MainCoordinatorMock.swift
//  MVPMoviesTests
//
//  Created by Kresimir Levarda on 24.01.2022..
//

@testable import MVPMovies

class MainCoordinatorMock: MainCoordinatorProtocol {
    var presentMediaDetailsCalledCount = 0
    var lastPresentedMedia: Media?
    func presentMediaDetails(for media: Media) {
        presentMediaDetailsCalledCount += 1
        lastPresentedMedia = media
    }
}
