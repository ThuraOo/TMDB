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
    
    private var viewModel: MovieViewModel!
    
    func initiate(with viewModel: MovieViewModel, for type: MovieSectionType) {
        self.viewModel = viewModel
        updateFavoriteButton()
        titleLabel.text = viewModel.movieName
        popularityLabel.text = "popularity : \(viewModel.popularity!)"
        let urlString = "https://image.tmdb.org/t/p/\(Util.imageSize)\(viewModel.imgUrl!)"
        imageView.kf.setImage(with: URL(string: urlString))
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        DataManager.toggleFavorite(id: viewModel.id!)
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let favorite = DataManager.getFavorite(id: viewModel.id!)
        if (favorite) {
            let config = UIImage.SymbolConfiguration(scale: .medium)
            favoriteBtn.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        } else {
            let config = UIImage.SymbolConfiguration(scale: .medium)
            favoriteBtn.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        }
        favoriteBtn.setTitle("", for: .normal)
    }
}
