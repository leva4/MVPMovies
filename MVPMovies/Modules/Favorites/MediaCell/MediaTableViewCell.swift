//
//  MediaTableViewCell.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit

class MediaTableViewCell: BaseTableViewCell {
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var rateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setup(_ media: Media) {
        titleLabel.text = media.getTitle()
        if let overview = media.overview, !overview.isEmpty {
            descriptionLabel.text = overview
        } else {
            descriptionLabel.text = "This Media is missing an overview. Help us improve by adding your overview @TMDB"
        }
        rateLabel.text = media.getRateText()
        coverImageView.downloadImage(media.getPosterUrl())
    }
}
