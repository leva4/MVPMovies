//
//  SearchViewModel.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel, SearchViewModelProtocol {
    private let favoriteService: FavoritesServiceProtocol
    private let mediaAvoidanceService: MediaAvoidanceServiceProtocol
    private let networkingService: SearchNetworkingServiceProtocol
    private let coordinator: MainCoordinatorProtocol
    
    private let refreshTrigger = PublishSubject<Void>()
    
    init(
        coordinator: MainCoordinatorProtocol,
        searchNetworkingService: SearchNetworkingServiceProtocol = SearchNetworkingService(),
        favoriteService: FavoritesServiceProtocol = FavoritesService(),
        mediaAvoidanceService: MediaAvoidanceServiceProtocol = MediaAvoidanceService()) {
            self.coordinator = coordinator
            self.favoriteService = favoriteService
            self.mediaAvoidanceService = mediaAvoidanceService
            self.networkingService = searchNetworkingService
            super.init()
        }
    
    func configure(with input: Input) -> Output {
        // TODO: check this
        let source = Observable.merge(refreshTrigger.asObservable(), input.querySubject.mapToVoid())
        let mediaResults: Driver<[Media]> = source.withLatestFrom(input.querySubject)
            .debounce(.milliseconds(400), scheduler: SerialDispatchQueueScheduler(qos: .background))
            .flatMapLatest({ [weak self] query -> Observable<[Media]> in
                guard let self = self, self.isValidQuery(query) else { return .just([]) }
                return self.search(for: query)
            })
            .map({ [weak self] media  -> [Media] in
                guard let self = self else { return [] }
                return media.filter({ !self.favoriteService.isInFavorites($0) })
            })
            .map({ [weak self] media  -> [Media] in
                guard let self = self else { return [] }
                return media.filter({ !self.mediaAvoidanceService.shouldIgnoreMedia(with: $0.id) })
            })
            .asDriver(onErrorJustReturn: [])

        return .init(mediaResults: mediaResults)
    }
    
    func toMediaDetails(_ selectedMedia: Media) {
        self.coordinator.presentMediaDetails(for: selectedMedia)
    }
}

extension SearchViewModel {
    func favorite(media: Media) {
        handleAddToFavorite(media)
    }

    func ignore(media: Media) {
        handleAddToIgnoredMedia(media)
    }

    private func isValidQuery(_ query: String) -> Bool {
        return query != ""
    }

    private func search(for query: String) -> Observable<[Media]> {
        return networkingService.search(for: query).asObservable()
            .catch({ [weak self] error -> Observable<[Media]> in
                self?.errorSubject.onNext(error)
                return .just([])
            })
    }
}

// MARK: Favorite and Ignore handles
private extension SearchViewModel {
    func handleAddToFavorite(_ media: Media) {
        favoriteService.addToFavorites(media)
        refreshTrigger.onNext(())
    }

    func handleAddToIgnoredMedia(_ media: Media) {
        mediaAvoidanceService.ignoreMedia(with: media.id)
        refreshTrigger.onNext(())
    }
}
