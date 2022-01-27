//
//  LocalStorageServiceMock.swift
//  MVPMoviesTests
//
//  Created by Kresimir Levarda on 26.01.2022..
//

import RxSwift

@testable import MVPMovies

class LocalStorageServiceMock: LocalStorageServiceProtocol {
    let mockRefreshStorage = PublishSubject<Void>()
    func observeChanges<Element: Decodable>(_ type: Element.Type, _ keyPath: String) -> Observable<Void> {
        return mockRefreshStorage.asObservable()
    }
}
