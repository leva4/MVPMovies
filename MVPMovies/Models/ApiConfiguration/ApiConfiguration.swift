//
//  ApiConfiguration.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

struct ApiConfiguration: Codable {
    let imagesConfiguration: ApiImagesConfiguration

    enum CodingKeys: String, CodingKey {
        case imagesConfiguration = "images"
    }
}
