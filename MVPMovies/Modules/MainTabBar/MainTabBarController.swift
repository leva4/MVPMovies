//
//  MainTabBarController.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift
import RxCocoa

final class MainTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }
    
    func setupTabBar() {        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = .systemBackground
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers,
              let targetIndex = tabViewControllers.firstIndex(of: viewController),
              let targetView = tabViewControllers[targetIndex].view,
              let currentViewController = selectedViewController,
              let currentIndex = tabViewControllers.firstIndex(of: currentViewController)
        else { return false }
        
        if currentIndex != targetIndex {
            animateToView(targetView, at: targetIndex, from: currentViewController.view, at: currentIndex)
        }
        return true
    }
}

private extension MainTabBarController {
    func animateToView(_ toView: UIView, at toIndex: Int, from fromView: UIView, at fromIndex: Int) {
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.width
        let offset = toIndex > fromIndex ? screenWidth : -screenWidth
        
        toView.frame.origin = CGPoint(
            x: toView.frame.origin.x + offset,
            y: toView.frame.origin.y
        )
        
        fromView.superview?.addSubview(toView)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        let keyWindow = UIApplication.shared.delegate?.window
        let initialBackgroundColor = keyWindow??.backgroundColor
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
            toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
        }, completion: { _ in
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
            keyWindow??.backgroundColor = initialBackgroundColor
        })
    }
}
