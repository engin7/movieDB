//
//  Movie.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation

// Network Response
struct ResultArray:  Codable {
     var results = [Movie]()
}


struct Movie: Codable {
    
    var title                = ""
    var overview             = ""
    var release_date         = ""
    var posterImagePath      = ""
    var averageVote          = 0.0
    var popularity           = 0.0
    var vote_count           = 0.0
    var id                   = 0
    var backdropImagePath:   String?
    var tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case posterImagePath = "poster_path"
        case backdropImagePath = "backdrop_path"
        case averageVote = "vote_average"
        case title, overview, release_date
        case popularity, vote_count, id, tagline
     }
    
}
