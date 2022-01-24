//
//  FavoritesViewController.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class FavoritesViewController: BaseViewController {
    private let viewModel: FavoritesViewModelProtocol
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        setupTableView()
        setupObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: Data
private extension FavoritesViewController {
    func setupObservables() {
        let viewModeOutput = viewModel.configure()

        viewModeOutput.favoriteMedia
            .map({ [MediaSection(items: $0)] })
            .drive(tableView.rx.items(dataSource: createDataSource()))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Media.self).asObservable()
            .subscribe(onNext: { [weak self] media in
                self?.viewModel.toMediaDetails(media)
            })
            .disposed(by: disposeBag)
    }
}


// MARK: Table View
private extension FavoritesViewController {
    func setupTableView() {
        let mediaCellNib = UINib(nibName: MediaTableViewCell.reuseID, bundle: nil)
        tableView.register(mediaCellNib, forCellReuseIdentifier: MediaTableViewCell.reuseID)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    func createDataSource() -> RxTableViewSectionedReloadDataSource<MediaSection> {
        let cellConfiguration: TableViewSectionedDataSource<MediaSection>.ConfigureCell = { _, tableView, indexPath, media in
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.reuseID, for: indexPath)
            guard let cell = dequeuedCell as? MediaTableViewCell else { return UITableViewCell() }
            cell.setup(media)
            return cell
        }
        let dataSource = RxTableViewSectionedReloadDataSource<MediaSection>(configureCell: cellConfiguration)
        return dataSource
    }
}
