//
//  ApiImagesConfiguration.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

struct ApiImagesConfiguration: Codable {
    let secureBaseUrl: String

    enum CodingKeys: String, CodingKey {
        case secureBaseUrl = "secure_base_url"
    }
}
