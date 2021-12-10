//
//  MovieDetailPresenter.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import SwiftyJSON

protocol MovieDetailPresenterOutput {
    func updateMovieDetailView(viewModel: MovieDetailViewModel)
}

class MovieDetailPresenter {
    
    var output: MovieDetailPresenterOutput!
    
    private func buildViewModel(data: JSON!) {
        let id = data["id"].intValue
        let movieName = data["title"].stringValue
        let tagLine = data["tagline"].stringValue
        let description = data["overview"].stringValue
        var productionCompanies = ""
        let productionCompanysArray = data["production_companies"].arrayValue
        for company in productionCompanysArray {
            productionCompanies = productionCompanies + company["name"].stringValue + ", "
        }
        let rating = data["vote_average"].stringValue
        let popularity = data["popularity"].stringValue
        let imgUrl = data["poster_path"].stringValue
        let viewModel = MovieDetailViewModel(id: id, movieName: movieName, tagLine: tagLine, description: description, productionCompany: productionCompanies, rating: rating, popularity: popularity, imgUrl: imgUrl)
        output.updateMovieDetailView(viewModel: viewModel)
    }
}

extension MovieDetailPresenter: MovieDetailInterorOutput {
    func parseMovieDetailData(data: JSON!) {
        buildViewModel(data: data)
    }
}
