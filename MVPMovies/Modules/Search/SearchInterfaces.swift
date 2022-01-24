//
//  SearchInterfaces.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift
import RxCocoa

extension SearchViewModel {
    struct Input {
        var querySubject: Observable<String>
    }

    struct Output {
        var mediaResults: Driver<[Media]>!
    }
}

protocol SearchViewModelProtocol: BaseViewModel {    
    func configure(with input: SearchViewModel.Input) -> SearchViewModel.Output
    func toMediaDetails(_ selectedMedia: Media)
    func favorite(media: Media)
    func ignore(media: Media)
}

protocol SearchNetworkingServiceProtocol {
    func search(for query: String) -> Single<[Media]>
}
