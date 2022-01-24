//
//  MediaAvoidanceServiceMock.swift
//  MVPMoviesTests
//
//  Created by Kresimir Levarda on 24.01.2022..
//

@testable import MVPMovies

class MediaAvoidanceServiceMock: MediaAvoidanceServiceProtocol {
    var mediaToIgnore = [Int]()

    func shouldIgnoreMedia(with id: Int) -> Bool {
        return mediaToIgnore.contains(id)
    }

    func ignoreMedia(with id: Int) {
        mediaToIgnore.append(id)
    }
}
