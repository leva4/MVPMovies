//
//  RxURLSessionError.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

enum RxURLSessionError: Error {
    case unknown
    case invalidResponse(URLResponse)
    case requestFailed(HTTPURLResponse, Data)
}
