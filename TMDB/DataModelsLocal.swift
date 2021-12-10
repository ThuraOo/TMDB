//
//  DataModelsLocal.swift
//  TMDB
//
//  Created by ThuraOo on 10/12/2021.
//

import RealmSwift

class MovieCellLocalData: Object {
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

class MovieDetailLocalData: Object {
    @objc dynamic var id = -1
    @objc dynamic var movieName = ""
    @objc dynamic var tagLine = ""
    @objc dynamic var movieDescription = ""
    @objc dynamic var productionCompany = ""
    @objc dynamic var rating = ""
    @objc dynamic var popularity = ""
    @objc dynamic var favorite = false
    @objc dynamic var imgUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
