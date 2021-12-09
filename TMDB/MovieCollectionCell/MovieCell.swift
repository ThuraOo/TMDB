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
    @IBOutlet weak var favoriteBtn: UIButton!
    
    func initiate(with viewModel: MovieViewModel, for type: MovieSectionType) {
        favoriteBtn.setTitle("", for: .normal)
        titleLabel.text = viewModel.movieName
        popularityLabel.text = "popularity : \(viewModel.popularity!)"
        let urlString = "https://image.tmdb.org/t/p/\(Util.imageSize)\(viewModel.imgUrl!)"
        imageView.kf.setImage(with: URL(string: urlString))
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        favoriteBtn.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        favoriteBtn.setTitle("", for: .normal)
    }
}
