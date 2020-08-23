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
   
    private let network = NetworkManager.shared
    var movie  : Movie?

    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
   
 
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        self.view.backgroundColor = .white
        self.overview.text = movie?.overview
        
        if movie != nil {
            rating.text = String(movie!.averageVote)
            let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + (movie!.posterImagePath))
            self.image.kf.setImage(with: imageURL)
        }
 
        
    }
    
}

