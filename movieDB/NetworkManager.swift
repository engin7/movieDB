//
//  NetworkManager.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Alamofire


class NetworkManager {
    
static let shared = NetworkManager() // singleton

private var apiKey: String?
private let baseURL = "https://api.themoviedb.org/3/search/movie"
private let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming"
 
var upcomingMovies: [Movie] = []
private var dataTask: URLSessionDataTask? = nil

 
 
    typealias SearchComplete = (Bool) -> Void
 
    func upcomingMovies(completion: @escaping SearchComplete) {
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            let Keys =  NSDictionary(contentsOfFile: path) //be sure to add your api key to keys.plist
            apiKey = Keys?.value(forKey: "API_Key") as? String
        }

    let url = upcomingURL + "?api_key=" + apiKey! + "&language=en-US&page=&page=1"

        AF.request(url)
    .validate()
    .responseDecodable(of: ResultArray.self) { (response) in
      guard let films = response.value else { return }
        self.upcomingMovies =  films.results
        completion(true)
    }
    
    }

}
