//
//  MediaSection.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxDataSources

struct MediaSection {
    var items: [Item]
}

extension MediaSection: SectionModelType {
    typealias Item = Media

    init(original: MediaSection, items: [Item]) {
        self = original
        self.items = items
    }
}
