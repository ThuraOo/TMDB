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
}

class HomeInteractor {
     
    var output: HomeInteractorOutPut!
    private var popularMovies: JSON!
    private var upcomingMovies: JSON!
    
    private func getPopularMovieData() {
        NetworkManager.getPopularMovieData() { json, error in
            if let json = json {
                self.popularMovies = JSON(json)
            } else {
                self.popularMovies = [:]
                print(error!)
            }
            self.output.parsePopularMoviesData(data: self.popularMovies)
        }
    }
    
    private func getUpcomingMovieData() {
        NetworkManager.getUpcomingMovieData() { json, error in
            if let json = json {
                self.upcomingMovies = JSON(json)
            } else {
                self.upcomingMovies = [:]
                print(error!)
            }
            self.output.parseUpcomingMoviesData(data: self.upcomingMovies)
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
