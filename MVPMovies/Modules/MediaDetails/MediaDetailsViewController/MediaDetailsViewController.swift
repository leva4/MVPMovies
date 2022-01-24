//
//  MediaDetailsViewController.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit

class MediaDetailsViewController: BaseViewController {
    private let viewModel: MediaDetailsViewModelProtocol

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    init(viewModel: MediaDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeBaseErrors(from: viewModel)

        let viewModelOutput = viewModel.configure()
        let media = viewModelOutput.media

        setupDetails(for: media)
    }

    private func setupDetails(for media: Media) {
        posterImageView.downloadImage(media.getPosterUrl())
        title = media.getTitle()
        descriptionLabel.text = media.overview
        rateLabel.text = media.getRateText()
    }
}
