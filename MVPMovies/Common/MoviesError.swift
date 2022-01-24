//
//  MoviesError.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

enum MoviesError: Error {
    case general
    case mappingFailed
    case weakSelf
    case networking
}
