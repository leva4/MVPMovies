//
//  MediaAvoidanceService.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

protocol MediaAvoidanceServiceProtocol {
    func shouldIgnoreMedia(with id: Int) -> Bool
    func ignoreMedia(with id: Int)
}

class MediaAvoidanceService: MediaAvoidanceServiceProtocol {
    func shouldIgnoreMedia(with id: Int) -> Bool {
        return LocalStorage.mediaIdsToAvoid.contains(id)
    }

    func ignoreMedia(with id: Int) {
        LocalStorage.mediaIdsToAvoid.insert(id)
    }
}
