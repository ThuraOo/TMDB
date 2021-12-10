//
//  HomePresenter.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//
import SwiftyJSON

protocol HomePresenterOutput {
    func updatePopularView(viewModels: [MovieViewModel])
    func updateUpcomingView(viewModels: [MovieViewModel])
    func toggleOfflineLabel(show: Bool)
}

class HomePresenter {
    
    var output: HomePresenterOutput!
    
    private func buildViewModel(data _data: JSON!, for type: MovieSectionType) {
        let data = _data["results"].arrayValue
        var viewModelArray = [MovieViewModel]()
        for singleData in data {
            let id = singleData["id"].intValue
            let movieName = singleData["title"].stringValue
            let popularity = singleData["popularity"].stringValue
            var imgUrl = ""
            switch type {
            case .popular: imgUrl = singleData["backdrop_path"].stringValue
            case .upcoming: imgUrl = singleData["poster_path"].stringValue
            }
            viewModelArray.append( MovieViewModel(id: id, movieName: movieName, popularity: popularity, favorite: false, imgUrl: imgUrl) )
        }
        switch type {
        case .popular: output.updatePopularView(viewModels: viewModelArray)
        case .upcoming: output.updateUpcomingView(viewModels: viewModelArray)
        }
        output.toggleOfflineLabel(show: false)
    }
    
    private func buildViewModel(data : [MovieCellLocalData]!, for type: MovieSectionType) {
        var viewModelArray = [MovieViewModel]()
        for singleData in data {
            let id = singleData.id
            let movieName = singleData.movieName
            let popularity = singleData.popularity
            let favorite = singleData.favorite
            let imgUrl = singleData.imgUrl
            viewModelArray.append( MovieViewModel(id: id, movieName: movieName, popularity: popularity, favorite: favorite, imgUrl: imgUrl) )
        }
        switch type {
        case .popular: output.updatePopularView(viewModels: viewModelArray)
        case .upcoming: output.updateUpcomingView(viewModels: viewModelArray)
        }
        output.toggleOfflineLabel(show: true)
    }
}

extension HomePresenter: HomeInteractorOutPut {
    func parsePopularMoviesLocalData(data: [MovieCellLocalData]!) {
        buildViewModel(data: data, for: .popular)
    }
    
    func parseUpcomingMoviesLocalData(data: [MovieCellLocalData]!) {
        buildViewModel(data: data, for: .upcoming)
    }
    
    func parsePopularMoviesData(data : JSON!) {
        buildViewModel(data: data, for: .popular)
    }
    
    func parseUpcomingMoviesData(data : JSON!) {
        buildViewModel(data: data, for: .upcoming)
    }
}
