//
//  BaseTableViewCell.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
