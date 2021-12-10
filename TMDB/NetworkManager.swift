//
//  NetworkManager.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//

import Alamofire
import SwiftyJSON

class NetworkManager {
    
    //get popular movies from api
    static func getPopularMovieData( completion: @escaping (Any?, Error?) -> Void) {
        let parms = [
            "api_key" : Util.apiKey,
            "language" : Util.language
        ]
        AF.request("\(Util.baseURL)popular", parameters: parms).responseJSON { response in
            switch(response.result) {
            case .success(let json) : completion(json, nil)
            case .failure(let error) :
                print(error)
                completion(nil, error)
            }
        }
    }
    
    //get upcoming movies from api
    static func getUpcomingMovieData( completion: @escaping (Any?, Error?) -> Void) {
        let parms = [
            "api_key" : Util.apiKey,
            "language" : Util.language
        ]
        AF.request("\(Util.baseURL)upcoming", parameters: parms).responseJSON { response in
            switch(response.result) {
            case .success(let json) : completion(json, nil)
            case .failure(let error) :
                print(error)
                completion(nil, error)
            }
        }
    }
    
    //get movie detail from api
    static func getMovieDetail(id: Int, completion: @escaping (Any?, Error?) -> Void) {
        let parms = [
            "api_key" : Util.apiKey,
            "language" : Util.language
        ]
        AF.request("\(Util.baseURL)\(id)", parameters: parms).responseJSON { response in
            switch(response.result) {
            case .success(let json) :
                completion(json, nil)
            case .failure(let error) :
                print(error)
                completion(nil, error)
            }
        }
    }
}

