//
//  SearchViewController.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchViewController: BaseViewController {
    private let viewModel: SearchViewModelProtocol
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeBaseErrors(from: viewModel)
        
        title = "Search"
        setupSearchTextField()
        setupTableView()
        setupObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: Data
private extension SearchViewController {
    func setupObservables() {
        let querySubject = searchTextField.rx.text
            .distinctUntilChanged()
            .skip(1) // Ignore initial empty query
            .unwrap()

        let viewModelInput = SearchViewModel.Input(querySubject: querySubject)
        let viewModelOutput = viewModel.configure(with: viewModelInput)

        viewModelOutput.mediaResults
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
private extension SearchViewController {
    func setupTableView() {
        let searchCellNib = UINib(nibName: SearchMediaTableViewCell.reuseID, bundle: nil)
        tableView.register(searchCellNib, forCellReuseIdentifier: SearchMediaTableViewCell.reuseID)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        configureKeyboardBehaviour(for: tableView)
    }

    func setupSearchTextField() {
        searchTextField.returnKeyType = .search
    }

    func createDataSource() -> RxTableViewSectionedReloadDataSource<MediaSection> {
        let cellConfiguration: TableViewSectionedDataSource<MediaSection>.ConfigureCell = { [weak self] _, tableView, indexPath, media in
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: SearchMediaTableViewCell.reuseID, for: indexPath)
            guard let cell = dequeuedCell as? SearchMediaTableViewCell else { return UITableViewCell() }
            self?.setup(cell: cell, with: media)
            return cell
        }
        let dataSource = RxTableViewSectionedReloadDataSource<MediaSection>(configureCell: cellConfiguration)
        return dataSource
    }

    func setup(cell: SearchMediaTableViewCell, with media: Media) {
        cell.setup(with: media)

        cell.favoriteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.favorite(media: media)
            })
            .disposed(by: cell.disposeBag)

        cell.ignoreButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.ignore(media: media)
            })
            .disposed(by: cell.disposeBag)
    }
}
