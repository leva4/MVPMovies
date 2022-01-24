//
//  AppCoordinator.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//
import UIKit
import RxSwift

class AppCoordinator {
    private let disposeBag = DisposeBag()
    private let window: UIWindow
    private var mainCoordinator: MainCoordinator?
    
    
    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func startApp() {
        startMain()
    }
}

// MARK: Main
private extension AppCoordinator {
    func startMain() {
        mainCoordinator = MainCoordinator()
        mainCoordinator?.start(in: window)
    }
}
