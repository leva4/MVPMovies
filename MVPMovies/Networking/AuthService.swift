//
//  AuthService.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

class AuthService {
    static func createAuthToken() -> URLQueryItem {
        #warning("Should not keep API token here in the real life scenario")
        return URLQueryItem(name: "api_key", value: "a3f14872cb5cd84d4aa89fe1dc34c9b9")
    }
}
