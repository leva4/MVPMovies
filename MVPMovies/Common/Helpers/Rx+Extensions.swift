//
//  Rx+Extensions.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift
import RxCocoa
import Foundation

extension ObservableType {
    /**
     Takes a sequence of optional elements and returns a sequence of non-optional elements,
     filtering out any nil values.
     - returns: An observable sequence of non-optional elements
     */
    public func unwrap<T>() -> Observable<T> where Element == T? {
        return filter { $0 != nil }.map { $0! }
    }

    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    func unwrap<T>() -> Driver<T> where Element == T? {
        return self.filter { $0 != nil }.map { $0! }
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
