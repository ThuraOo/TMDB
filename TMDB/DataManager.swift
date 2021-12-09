//
//  DataManager.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import RealmSwift
import SwiftyJSON

class MovieCellLocalData : Object {
    @objc dynamic var id = -1
    @objc dynamic var movieName = ""
    @objc dynamic var popularity = ""
    @objc dynamic var favorite = false
    @objc dynamic var imgUrl = ""
    @objc dynamic var type = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class DataManager {
    
    static func saveMovieCellDataLocal(from _data: JSON!, type: MovieSectionType) {
        let data = _data["results"].arrayValue
        let realm = try! Realm()
        
        for singleData in data {
            let movidId = singleData["id"].intValue
            let movieName = singleData["title"].stringValue
            let popularity = singleData["popularity"].stringValue
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
            
            let movieCellData = MovieCellLocalData()
            movieCellData.id = movidId
            movieCellData.movieName = movieName
            movieCellData.popularity = popularity
            movieCellData.imgUrl = imgUrl
            movieCellData.type = sectionType
            
            if let existingData = realm.objects(MovieCellLocalData.self).filter("id == \(movieCellData.id)").first {
                try! realm.write({ //if id exists, update the realm
                    existingData.movieName = movieName
                    existingData.popularity = popularity
                    existingData.imgUrl = imgUrl
                    existingData.type = sectionType
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
    
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
