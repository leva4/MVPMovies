//
//  UIImageView+Kingfisher.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func downloadImage(_ URL: Foundation.URL?) {
        guard let URL = URL else { return }
        self.kf.setImage(with: URL, placeholder: nil, options: [], completionHandler: nil)
    }
}
