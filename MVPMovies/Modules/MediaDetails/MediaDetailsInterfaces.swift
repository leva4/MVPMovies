//
//  MediaDetailsInterfaces.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

extension MediaDetailsViewModel {
    struct Output {
        var media: Media
    }
}

protocol MediaDetailsViewModelProtocol: BaseViewModel {
    func configure() -> MediaDetailsViewModel.Output
}
