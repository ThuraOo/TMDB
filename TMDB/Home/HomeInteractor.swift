//
//  HomeInteractor.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//
import SwiftyJSON

protocol HomeInteractorOutPut {
    func parsePopularMoviesData(data: JSON!)
    func parseUpcomingMoviesData(data: JSON!)
    func parsePopularMoviesLocalData(data: [MovieCellLocalData]!)
    func parseUpcomingMoviesLocalData(data: [MovieCellLocalData]!)
}

class HomeInteractor {
     
    var output: HomeInteractorOutPut!
    
    private func getPopularMovieData() {
        NetworkManager.getPopularMovieData() { json, error in
            if let json = json {
                self.output.parsePopularMoviesData(data: JSON(json))
                self.saveDataToLocal(from: JSON(json), type: .popular)
            } else {
                print(error!)
                self.loadDataFromLocal(type: .popular)
            }
        }
    }
    
    private func getUpcomingMovieData() {
        NetworkManager.getUpcomingMovieData() { json, error in
            if let json = json {
                self.output.parseUpcomingMoviesData(data: JSON(json))
                self.saveDataToLocal(from: JSON(json), type: .upcoming)
            } else {
                print(error!)
                self.loadDataFromLocal(type: .upcoming)
            }
        }
    }
    
    private func saveDataToLocal(from _data: JSON!, type: MovieSectionType) {
        DataManager.saveMovieCellDataLocal(from: _data, type: type)
    }
    
    private func loadDataFromLocal(type: MovieSectionType) {
        let localData = DataManager.loadMovieCellDataLocal(type: type)
        if (type == .popular) {
            output.parsePopularMoviesLocalData(data: localData)
        } else
        {
            output.parseUpcomingMoviesLocalData(data: localData)
        }
    }
}

extension HomeInteractor: HomeViewControllerOutput {
    func getPopularMovies() {
        getPopularMovieData()
    }
    
    func getUpcomingMovies() {
        getUpcomingMovieData()
    }
}
