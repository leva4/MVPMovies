//
//  Array+Extensions.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

public extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
