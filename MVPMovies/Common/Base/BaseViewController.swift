//
//  BaseViewController.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift
import RxKeyboard
import Reachability
import RxReachability

class BaseViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var reachability: Reachability?
    
    init() {
        reachability = try? Reachability()
        try? reachability?.startNotifier()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observeReachabilityStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? reachability?.startNotifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability?.stopNotifier()
    }
}

// MARK: Base Keyboard Handling
extension BaseViewController {
    /// - Parameter scrollView: UIScrollView to configure
    public func configureKeyboardBehaviour(for scrollView: UIScrollView, withInitialInset: UIEdgeInsets? = nil) {
        scrollView.keyboardDismissMode = .interactive

        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak scrollView] keyboardVisibleHeight in
                var bottomInset = keyboardVisibleHeight
                if let insets = withInitialInset {
                    bottomInset += insets.bottom
                }
                scrollView?.contentInset.bottom = bottomInset
            })
            .disposed(by: disposeBag)
    }
}


// MARK: Base Error Handling
extension BaseViewController {
    func observeBaseErrors(from viewModel: BaseViewModel) {
        viewModel.errorSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }

    private func handleError(_ error: Error) {
        let noConnectionAlert = UIAlertController(
            title: "Something went wrong",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        noConnectionAlert.addAction(UIAlertAction(title: "OK 😞", style: .default, handler: nil))

        self.present(noConnectionAlert, animated: true, completion: nil)
    }
}

// MARK: Reachability Handling
private extension BaseViewController {
    func observeReachabilityStatus() {
        reachability?.rx.isReachable
            .skip(while: { $0 })
            .subscribe(onNext: { [weak self] reachable in
                reachable ?
                self?.notifyUserConnectionRestored() :
                self?.notifyUserConnectionUnreachable()
            })
            .disposed(by: disposeBag)
    }

    func notifyUserConnectionUnreachable() {
        let noConnectionAlert = UIAlertController(
            title: "No Internet connection ⚠️",
            message: "Looks like there is something wrong with the internet connection, please make sure your connection is stable.",
            preferredStyle: .alert
        )
        noConnectionAlert.addAction(UIAlertAction(title: "OK 😞", style: .default, handler: nil))
        self.present(noConnectionAlert, animated: true, completion: nil)
    }

    func notifyUserConnectionRestored() {
        let noConnectionAlert = UIAlertController(
            title: "Nice 🚀",
            message: "You are back online",
            preferredStyle: .alert
        )
        noConnectionAlert.addAction(UIAlertAction(title: "Yay 🎉", style: .default, handler: nil))
        self.present(noConnectionAlert, animated: true, completion: nil)
    }
}
