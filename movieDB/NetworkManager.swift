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
private let byIdURL = "https://api.themoviedb.org/3/movie"
private let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming"
private let nowplayingURL = "https://api.themoviedb.org/3/movie/now_playing"
    
var upcomingMovies: [Movie] = []
var nowplayingMovies:[Movie] = []
var searchedMovies:[Movie] = []
var similarMovies:[Movie] = []
var movieById:Movie?
    
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
    
    func nowplayingMovies(completion: @escaping SearchComplete) {
    
        let url = nowplayingURL + "?api_key=" + apiKey! + "&language=en-US&page=&page=1"

             AF.request(url)
         .validate()
         .responseDecodable(of: ResultArray.self) { (response) in
           guard let films = response.value else { return }
             self.nowplayingMovies =  films.results
             completion(true)
         }
    }
    
    func performSearch(searchText: String,completion: @escaping SearchComplete) {
       
            let url = baseURL + "?api_key=" + apiKey! + "&language=en-US&query=" + searchText + "&page=1&include_adult=false"
            
                AF.request(url)
            .validate()
            .responseDecodable(of: ResultArray.self) { (response) in
              guard let films = response.value else { return }
                self.searchedMovies =  films.results
                completion(true)
            }
           
       }
    
    func getMovieById(movie: Movie,completion: @escaping SearchComplete) {
        
        let api = "?api_key=" + apiKey! + "&language=en-US"
        let url = byIdURL + "/" + String(movie.id) + api
        
        AF.request(url)
        .validate()
        .responseDecodable(of: Movie.self) { (response) in
          guard let film = response.value else { return }
            self.movieById = film
            completion(true)
        }
    }
    
    func getSimilarMovie(movie: Movie,completion: @escaping SearchComplete) {
           
           let api = "/similar?api_key=" + apiKey! + "&language=en-US"
           let url = byIdURL + "/" + String(movie.id) + api
           
           AF.request(url)
           .validate()
           .responseDecodable(of: ResultArray.self) { (response) in
             guard let film = response.value else { return }
            self.similarMovies = film.results
               completion(true)
           }
       }
    
    
}
