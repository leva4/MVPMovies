//
//  AppDelegate.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window =  newWindow
        appCoordinator = AppCoordinator(window: newWindow)
        appCoordinator.startApp()
        ApiConfigurationService.shared.configure()
        return true
    }
}

