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
}

class HomePresenter {
    
    var output: HomePresenterOutput!
    
    private func buildViewModel(data _data: JSON!, for type: MovieSectionType) {
        let data = _data["results"].arrayValue
        var viewModelArray = [MovieViewModel]()
        for singleData in data {
            let movieName = singleData["title"].stringValue
            let popularity = singleData["popularity"].stringValue
            var imgUrl = ""
            switch type {
            case .popular: imgUrl = singleData["backdrop_path"].stringValue
            case .upcoming: imgUrl = singleData["poster_path"].stringValue
            }
            viewModelArray.append( MovieViewModel(movieName: movieName, popularity: popularity, favorite: false, imgUrl: imgUrl) )
        }
        switch type {
        case .popular: output.updatePopularView(viewModels: viewModelArray)
        case .upcoming: output.updateUpcomingView(viewModels: viewModelArray)
        }
        
    }
}

extension HomePresenter: HomeInteractorOutPut {
    func parsePopularMoviesData(data : JSON!) {
        buildViewModel(data: data, for: .popular)
    }
    
    func parseUpcomingMoviesData(data : JSON!) {
        buildViewModel(data: data, for: .upcoming)
    }
}
