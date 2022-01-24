//
//  MediaType.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

enum MediaType: String, Codable {
    case show = "tv"
    case movie
    case person

    enum CodingKeys: String, CodingKey {
        case show, movie, person
    }
}
