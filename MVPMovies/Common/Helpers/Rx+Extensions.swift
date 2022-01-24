//
//  Rx+Extensions.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift
import RxCocoa

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
