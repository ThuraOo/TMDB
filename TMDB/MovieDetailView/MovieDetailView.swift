//
//  MovieDetailView.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import UIKit
import Kingfisher

protocol MovieDetailViewOutput {
    func getMovieDetaildata(id: Int)
}

class MovieDetailView: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblProductionCompany: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var favoriteBtn: UIBarButtonItem!
    
    var id: Int!
    private var output: MovieDetailViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVIP()
        output.getMovieDetaildata(id: id)
        updateFavoriteButton()
    }
    
    @objc func toggleFavorite() {
        DataManager.toggleFavorite(id: id!)
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let favorite = DataManager.getFavorite(id: id!)
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        if (favorite) {
            let config = UIImage.SymbolConfiguration(scale: .medium)
            button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        } else {
            let config = UIImage.SymbolConfiguration(scale: .medium)
            button.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        }
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        favoriteBtn.customView = button
    }
    
    private func configureVIP() { //VIP circle
        let interacter = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        output = interacter
        interacter.output = presenter
        presenter.output = self
    }
    
    private func updateView(viewModel: MovieDetailViewModel) {
        lblMovieName.text = viewModel.movieName!
        lblTagLine.text = viewModel.tagLine!
        lblDescription.text = "\t" + viewModel.description!
        lblProductionCompany.text = viewModel.productionCompany!
        lblRating.text = "Rating: " + viewModel.rating!
        lblPopularity.text = "Popularity: " + viewModel.popularity!
        let urlString = "\(Util.imgBaseURL)\(Util.imageSize)\(viewModel.imgUrl!)"
        imgView.kf.setImage(with: URL(string: urlString))
    }
}

extension MovieDetailView: MovieDetailPresenterOutput {
    func updateMovieDetailView(viewModel: MovieDetailViewModel) {
        updateView(viewModel: viewModel)
    }
}
