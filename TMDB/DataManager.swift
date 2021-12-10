//
//  DataManager.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import RealmSwift
import SwiftyJSON

class DataManager {
    
    static func saveMovieCellDataLocal(from _data: JSON!, type: MovieSectionType) {
        let data = _data["results"].arrayValue
        let realm = try! Realm()
        
        for singleData in data {
            let movieCellData = MovieCellLocalData()
            movieCellData.id = singleData["id"].intValue
            movieCellData.movieName = singleData["title"].stringValue
            movieCellData.popularity = singleData["popularity"].stringValue
            var imgUrl = ""
            var sectionType = ""
            switch type {
            case .popular:
                imgUrl = singleData["backdrop_path"].stringValue
                sectionType = String(describing: MovieSectionType.popular)
            case .upcoming:
                imgUrl = singleData["poster_path"].stringValue
                sectionType = String(describing: MovieSectionType.upcoming)
            }
            
            movieCellData.imgUrl = imgUrl
            movieCellData.type = sectionType
            
            if let existingData = realm.objects(MovieCellLocalData.self).filter("id == \(movieCellData.id)").first {
                try! realm.write({ //if id exists, update the realm
                    existingData.movieName = movieCellData.movieName
                    existingData.popularity = movieCellData.popularity
                    existingData.imgUrl = movieCellData.imgUrl
                    existingData.type = movieCellData.type
                })
            } else {
                try! realm.write({ //if id not exist, add the realm
                    realm.add(movieCellData)
                })
            }
        }
    }
    
    static func loadMovieCellDataLocal(type: MovieSectionType) -> [MovieCellLocalData]{
        let realm = try! Realm()
        let data = realm.objects(MovieCellLocalData.self).filter("type == '\(String(describing: type))'")
        return data.toArray()
    }
    
    static func saveMovieDetailData(from data: JSON!) {
        let realm = try! Realm()
        let movieDetailData = MovieDetailLocalData()
        
        movieDetailData.id = data["id"].intValue
        movieDetailData.movieName = data["title"].stringValue
        movieDetailData.tagLine = data["tagline"].stringValue
        movieDetailData.movieDescription = data["overview"].stringValue
        var productionCompanies = ""
        let productionCompanysArray = data["production_companies"].arrayValue
        for company in productionCompanysArray {
            productionCompanies = productionCompanies + company["name"].stringValue + ", "
        }
        movieDetailData.productionCompany = productionCompanies
        movieDetailData.rating = data["vote_average"].stringValue
        movieDetailData.popularity = data["popularity"].stringValue
        movieDetailData.imgUrl = data["poster_path"].stringValue
        
        if let existingData = realm.objects(MovieDetailLocalData.self).filter("id == \(movieDetailData.id)").first {
            try! realm.write({ //if id exists, update the realm
                existingData.movieName = movieDetailData.movieName
                existingData.tagLine = movieDetailData.tagLine
                existingData.movieDescription = movieDetailData.movieDescription
                existingData.productionCompany = movieDetailData.productionCompany
                existingData.rating = movieDetailData.rating
                existingData.popularity = movieDetailData.popularity
                existingData.imgUrl = movieDetailData.imgUrl
            })
        } else {
            try! realm.write({ //if id not exist, add the realm
                realm.add(movieDetailData)
            })
        }
    }
    
    static func loadMovieDetailDataLocal(id: Int) -> MovieDetailLocalData?{
        let realm = try! Realm()
        if let data = realm.objects(MovieDetailLocalData.self).filter("id == \(id)").first {
            return data
        } else {
            return nil
        }
    }
    
    static func getFavorite(id: Int) -> Bool {
        let realm = try! Realm()
        if let data = realm.objects(MovieCellLocalData.self).filter("id == \(id)").first {
            return data.favorite
        }
        return false
    }
    
    static func toggleFavorite(id: Int) {
        let realm = try! Realm()
        if let data = realm.objects(MovieCellLocalData.self).filter("id == \(id)").first {
            try! realm.write({ 
                data.favorite = !data.favorite
            })
        }
    }
    
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
