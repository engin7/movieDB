//
//  NetworkManager.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Alamofire

// TODO:- Refactor Network functions

class NetworkManager {
    
static let shared = NetworkManager() // singleton

private var apiKey: String?
private let baseURL = "https://api.themoviedb.org/3/search/movie"
private let byIdURL = "https://api.themoviedb.org/3/movie"
private let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming"
private let nowplayingURL = "https://api.themoviedb.org/3/movie/now_playing"
    
var upcomingMovies: [Movie] = []
var nowplayingMovies:[Movie] = []
var searchedMovies:[Movie] = []
var similarMovies:[Movie] = []
var movieById:Movie?

enum GetType {
   case nowplaying
   case upcoming
   case search
   case similar
   case byId
 }

    typealias SearchComplete = (Bool) -> Void
 
    func getMovies(get: GetType, searchText: String?, movie: Movie?, completion: @escaping SearchComplete) {
        
        let url: String
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            let Keys =  NSDictionary(contentsOfFile: path) //be sure to add your api key to keys.plist
            apiKey = Keys?.value(forKey: "API_Key") as? String
        }
        
        switch get {
        case .nowplaying:
        url = nowplayingURL + "?api_key=" + apiKey! + "&language=en-US&page=&page=1"
        case .upcoming:
        url = upcomingURL + "?api_key=" + apiKey! + "&language=en-US&page=&page=1"
        case .search:
        let api = baseURL + "?api_key=" + apiKey! + "&language=en-US&query="
        url =  api + searchText! + "&page=1&include_adult=false"
        case .similar:
        let api = "/similar?api_key=" + apiKey! + "&language=en-US"
        url = byIdURL + "/" + String(movie!.id) + api
        case .byId:
        let api = "?api_key=" + apiKey! + "&language=en-US"
        url = byIdURL + "/" + String(movie!.id) + api
        }
         
        let AlamofireCall = AF.request(url).validate()
         
        switch get {
        case .byId:
            AlamofireCall.responseDecodable(of: Movie.self) { (response) in
                guard let film = response.value else { return }
                self.movieById = film
                completion(true)
            }
        default:
            AlamofireCall.responseDecodable(of: ResultArray.self) { (response) in
                guard let films = response.value else { return }
                switch get {
                case .nowplaying:
                    self.nowplayingMovies =  films.results
                case .upcoming:
                    self.upcomingMovies =  films.results
                case .search:
                    self.searchedMovies =  films.results
                case .similar:
                    self.similarMovies = films.results
                case .byId:
                    return
                }
                completion(true)
            }
        }
    }
     
}
