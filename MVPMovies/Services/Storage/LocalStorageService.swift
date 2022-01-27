//
//  LocalStorageService.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 26.01.2022..
//

import Foundation
import RxSwift

protocol LocalStorageServiceProtocol {
    func observeChanges<Element: Decodable>(_ type: Element.Type, _ keyPath: String) -> Observable<Void>
}

class LocalStorageService: LocalStorageServiceProtocol {
    func observeChanges<Element: Decodable>(_ type: Element.Type, _ keyPath: String) -> Observable<Void> {
        return UserDefaults.standard.rx
            .observeStorage(type, keyPath)
            .mapToVoid()
    }
}
