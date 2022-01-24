//
//  FavoritesViewController.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift
import RxCocoa

final class FavoritesViewController: BaseViewController {
    
    private let viewModel: FavoritesViewModel
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
