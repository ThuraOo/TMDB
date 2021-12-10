//
//  MovieDetailInteractor.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import SwiftyJSON

protocol MovieDetailInterorOutput {
    func parseMovieDetailData(data: JSON!)
}

class MovieDetailInteractor {
    
    var output: MovieDetailInterorOutput!
}

extension MovieDetailInteractor: MovieDetailViewOutput {
    func getMovieDetaildata(id: Int) {
        NetworkManager.getMovieDetail(id: id) { json, error in
            if let json = json {
                self.output.parseMovieDetailData(data: JSON(json))
            } else {
                print(error!)
            }
        }
    }
}
