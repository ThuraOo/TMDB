//
//  ViewModels.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//
// View-ready models to update the UI

struct MovieViewModel {
    var id: Int?
    var movieName: String?
    var popularity: String?
    var favorite: Bool?
    var imgUrl: String?
}

struct MovieDetailViewModel {
    var id: Int?
    var movieName: String?
    var tagLine: String?
    var description: String?
    var productionCompany: String?
    var rating: String?
    var popularity: String?
    var imgUrl: String?
}
