//
//  PaginateResponse.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

struct PaginateResponse<T: Codable>: Codable {
    let page: Int
    let results: [T]
}
