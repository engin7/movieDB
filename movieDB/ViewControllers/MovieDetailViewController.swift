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

class MovieDetailViewController: UIViewController, UICollectionViewDelegate {
   
    private let network = NetworkManager.shared
    var movie  : Movie?
    var similarMovies: [Movie]?
    private let collectionViewDataSource = SimilarMoviesDataSource()

    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imdb: UILabel!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = collectionViewDataSource
        collectionView.reloadData()
        self.title = movie?.title
        self.view.backgroundColor = .white
        overview.text = movie?.overview
        tagline.text = movie?.tagline
        tagline.adjustsFontSizeToFitWidth = true
        date.text = movie?.release_date
        
        if movie != nil {
            rating.text = String(movie!.averageVote)
            let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + (movie!.posterImagePath))
            self.image.kf.setImage(with: imageURL)
        }
  
    }
    
    
}

