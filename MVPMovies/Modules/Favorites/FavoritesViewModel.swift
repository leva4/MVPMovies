//
//  FavoritesViewModel.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift
import RxCocoa
import Foundation

final class FavoritesViewModel: BaseViewModel, FavoritesViewModelProtocol {
    private let mediaAvoidanceService: MediaAvoidanceServiceProtocol
    private let favoritesService: FavoritesServiceProtocol
    private let localStorageService: LocalStorageServiceProtocol
    private let backgroundQueue: SchedulerType
    private let coordinator: MainCoordinatorProtocol
    
    init(
        coordinator: MainCoordinatorProtocol,
        mediaAvoidanceService: MediaAvoidanceServiceProtocol = MediaAvoidanceService(),
        favoritesService: FavoritesServiceProtocol = FavoritesService(),
        localStorageService: LocalStorageServiceProtocol = LocalStorageService(),
        backgroundQueue: SchedulerType = SerialDispatchQueueScheduler(qos: .background)) {
            self.coordinator = coordinator
            self.mediaAvoidanceService = mediaAvoidanceService
            self.favoritesService = favoritesService
            self.localStorageService = localStorageService
            self.backgroundQueue = backgroundQueue
            super.init()
        }
    
    func configure() -> Output {
        let storageDidChange = Observable.merge(
            localStorageService.observeChanges(Set<Media>.self, "favorite_media"),
            localStorageService.observeChanges(Set<Int>.self, "media_ids_to_avoid")
        )
        
        let favoriteMedia: Driver<[Media]> =  storageDidChange
            .startWith(()) // Do the initial load
            .map({ [weak self] _ -> [Media] in
                guard let self = self else { return [] }
                let media = self.favoritesService.getFavorites()
                return self.removeIgnoredMedia(from: media)
            })
            .map({ media -> [Media] in
                return media.sorted(by: Media.sort())
            })
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: [])
        
        return .init(favoriteMedia: favoriteMedia)
    }
    
    func toMediaDetails(_ selectedMedia: Media) {
        self.coordinator.presentMediaDetails(for: selectedMedia)
    }
    
    private func removeIgnoredMedia(from media: [Media]) -> [Media] {
        return media.filter({ !mediaAvoidanceService.shouldIgnoreMedia(with: $0.id) })
    }
}
