//
//  SearchMediaTableViewCell.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift

class SearchMediaTableViewCell: BaseTableViewCell {
    @IBOutlet private var mediaTitleLabel: UILabel!
    @IBOutlet public var favoriteButton: UIButton!
    @IBOutlet public var ignoreButton: UIButton!
    @IBOutlet weak var posterView: UIImageView!
    
    func setup(with media: Media) {
        mediaTitleLabel.text = media.getTitle()
        posterView.downloadImage(media.getPosterUrl())
    }
}
