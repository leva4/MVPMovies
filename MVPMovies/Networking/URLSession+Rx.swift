//
//  URLSession+Rx.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation
import RxSwift
import UIKit

extension Reactive where Base: URLSession {
    func data(request: URLRequest) -> Observable<Data> {
        return response(request: request)
            .map { response, data -> Data in
                guard 200 ..< 300 ~= response.statusCode else {
                    throw RxURLSessionError.requestFailed(response, data)
                }
                return data
            }
    }

    func decodable<D: Decodable>(request: URLRequest,
                                 type: D.Type) -> Observable<D> {
        return data(request: request).map { data in
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        }
    }
}

