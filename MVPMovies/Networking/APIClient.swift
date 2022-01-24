//
//  APIClient.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation
import RxSwift

class APIClient {
    private let baseURL = URL(string: App.baseUrlString)!
    static var shared = APIClient()

    private init() {}

    func request<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.decodable(request: request, type: T.self)
    }
}
