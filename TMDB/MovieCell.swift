//
//  MovieCell.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//

import UIKit
import Kingfisher

class MovieCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    func initiate(with viewModel: MovieViewModel, for type: MovieSectionType) {
        titleLabel.text = viewModel.movieName
        popularityLabel.text = "popularity : \(viewModel.popularity!)"
        let urlString = "https://image.tmdb.org/t/p/\(Util.imageSize)\(viewModel.imgUrl!)"
        
        imageView.kf.setImage(with: URL(string: urlString))
//        switch type {
//        case .popular :
//            titleLabel.font = titleLabel.font.withSize(18)
//            popularityLabel.font = popularityLabel.font.withSize(15)
//        case .upcoming :
//            titleLabel.font = titleLabel.font.withSize(15)
//            popularityLabel.font = popularityLabel.font.withSize(13)
//        }
    }
    
}
