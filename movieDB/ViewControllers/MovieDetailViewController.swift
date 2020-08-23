//
//  MovieDetailViewController.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

// * Movie detail data should getted from “movie/{movie_id}”.
//* Similar movies data should getted from “movie/{movie_id}\similar”.
//* User can go to the imbd page of the movie with “imdb_id” parameter.
//* User can go to the similar movies detail.

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie  : Movie
    let movieID: Int
    
    init(movie: Movie) {
        self.movie   =  movie
        self.movieID = movie.id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie.title

    }
    
}
