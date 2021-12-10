//
//  MovieDetailPresenter.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import SwiftyJSON

protocol MovieDetailPresenterOutput {
    func updateMovieDetailView(viewModel: MovieDetailViewModel)
    func toggleOfflineLabel(show: Bool)
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
        output.toggleOfflineLabel(show: false)
    }
    
    private func buildViewModel(data: MovieDetailLocalData!) {
        let id = data.id
        let movieName = data.movieName
        let tagLine = data.tagLine
        let description = data.movieDescription
        let productionCompanies = data.productionCompany
        let rating = data.rating
        let popularity = data.popularity
        let imgUrl = data.imgUrl
        let viewModel = MovieDetailViewModel(id: id, movieName: movieName, tagLine: tagLine, description: description, productionCompany: productionCompanies, rating: rating, popularity: popularity, imgUrl: imgUrl)
        output.updateMovieDetailView(viewModel: viewModel)
        output.toggleOfflineLabel(show: true)
    }
}

extension MovieDetailPresenter: MovieDetailInterorOutput {
    func parseMovieDetailLocalData(data: MovieDetailLocalData) {
        buildViewModel(data: data)
    }
    
    func parseMovieDetailData(data: JSON!) {
        buildViewModel(data: data)
    }
}
