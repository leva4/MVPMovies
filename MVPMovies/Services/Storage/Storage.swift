//
//  Storage.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation
import RxSwift

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

extension Reactive where Base: NSObject {
    func observeStorage<Element: Decodable>(_ type: Element.Type, _ keyPath: String) -> Observable<Element?> {
        return self.observe(Data.self, keyPath)
            .debounce(.microseconds(100), scheduler: MainScheduler.asyncInstance)
            .unwrap()
            .map { data in
                let value = try? JSONDecoder().decode(Element.self, from: data)
                return value
            }
    }
}

