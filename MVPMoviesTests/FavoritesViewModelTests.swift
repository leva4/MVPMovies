//
//  FavoritesViewModelTests.swift
//  MVPMoviesTests
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import MVPMovies

class FavoritesViewModelTests: XCTestCase {
    var sut: FavoritesViewModel!
    var scheduler: TestScheduler!
    var coordinator: MainCoordinatorMock!
    var mediaAvoidanceService: MediaAvoidanceServiceProtocol!
    var favoritesService: FavoritesServiceProtocol!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()

        scheduler = TestScheduler(initialClock: 0)
        coordinator = MainCoordinatorMock()
        mediaAvoidanceService = MediaAvoidanceServiceMock()
        favoritesService = FavoritesServiceMock()
        sut = FavoritesViewModel(
            coordinator: coordinator,
            mediaAvoidanceService: mediaAvoidanceService,
            favoritesService: favoritesService,
            backgroundQueue: scheduler
        )
        disposeBag = DisposeBag()
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    func testFavoriteMedia_withNoFavorites() {
        let expectedResults: [Recorded<Event<[Media]>>] = [.next(0, [])]

        let observer = scheduler.createObserver([Media].self)

        let viewModelOutput = sut.configure()

        viewModelOutput.favoriteMedia
            .asObservable()
            .bind(to: observer)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(observer.events, expectedResults)
    }

    func testFavoriteMedia_withFavorites() {
        let mockedMovie = Media.createFrom(jsonFile: "Media1")!
        favoritesService.addToFavorites(mockedMovie)

        let expectedResults: [Recorded<Event<[Media]>>] = [.next(0, [mockedMovie])]

        let observer = scheduler.createObserver([Media].self)

        let viewModelOutput = sut.configure()

        viewModelOutput.favoriteMedia
            .asObservable()
            .bind(to: observer)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(observer.events, expectedResults)
    }

    func testFavoriteMedia_withFavoritesAndIgnored() {
        let mockedMovie1 = Media.createFrom(jsonFile: "Media1")!
        favoritesService.addToFavorites(mockedMovie1)
        mediaAvoidanceService.ignoreMedia(with: mockedMovie1.id)

        let mockedMovie2 = Media.createFrom(jsonFile: "Media2")!
        favoritesService.addToFavorites(mockedMovie2)

        let expectedResults: [Recorded<Event<[Media]>>] = [.next(0, [mockedMovie2])]

        let observer = scheduler.createObserver([Media].self)

        let viewModelOutput = sut.configure()

        viewModelOutput.favoriteMedia
            .asObservable()
            .bind(to: observer)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(observer.events, expectedResults)
    }

    func testFavoriteMedia_afterFavoritesChanged() {
        let mockedMovie1 = Media.createFrom(jsonFile: "Media1")!
        favoritesService.addToFavorites(mockedMovie1)

        let mockedMovie2 = Media.createFrom(jsonFile: "Media2")!

        let expectedResults: [Recorded<Event<[Media]>>] = [
            .next(0, [mockedMovie1]),
            .next(10, [mockedMovie1, mockedMovie2]),
        ]

        let observer = scheduler.createObserver([Media].self)

        let viewModelOutput = sut.configure()

        scheduler.scheduleAt(0, action: { [unowned self] in
            viewModelOutput.favoriteMedia
                .asObservable()
                .bind(to: observer)
                .disposed(by: disposeBag)
        })
        scheduler.advanceTo(10)

        favoritesService.addToFavorites(mockedMovie2)

        XCTAssertEqual(observer.events, expectedResults)
    }

    func testMediaSelected() {
        let mockedMovie = Media.createFrom(jsonFile: "Media1")!
        favoritesService.addToFavorites(mockedMovie)
        
        let viewModelOutput = sut.configure()
        viewModelOutput.favoriteMedia.drive().disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(0, mockedMovie)])
            .subscribe(onNext: { [weak self] media in
                self?.sut.toMediaDetails(media)
            })
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(coordinator.presentMediaDetailsCalledCount, 1)
        XCTAssertEqual(coordinator.lastPresentedMedia, mockedMovie)
    }
}
