//
//  Decodable+Extensions.swift
//  MVPMoviesTests
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation
@testable import MVPMovies

extension Decodable {
    static func createFrom(jsonFile: String) -> Self? {
        let url = Bundle.main.url(forResource: jsonFile, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(self, from: data)
    }
}
