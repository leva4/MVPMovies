//
//  LocalStorage.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

struct LocalStorage {
    @Storage(key: "favorite_media", defaultValue: [])
    static var favoriteMedia: Set<Media>

    @Storage(key: "media_ids_to_avoid", defaultValue: [])
    static var mediaIdsToAvoid: Set<Int>
}
