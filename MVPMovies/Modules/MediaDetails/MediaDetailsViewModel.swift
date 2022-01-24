//
//  MediaDetailsViewModel.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

class MediaDetailsViewModel: BaseViewModel, MediaDetailsViewModelProtocol {
    private let media: Media

    init(_ media: Media) {
        self.media = media
        super.init()
    }

    func configure() -> MediaDetailsViewModel.Output {
        return .init(media: media)
    }
}
