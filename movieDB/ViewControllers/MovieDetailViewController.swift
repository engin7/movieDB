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

class MovieDetailViewController: UIViewController, UICollectionViewDelegate, UITextViewDelegate {
   
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
    @IBOutlet weak var imdb: UITextView!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = collectionViewDataSource
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
        
        let attributedString = NSMutableAttributedString(string: "IMDb")
        attributedString.addAttribute(.link, value: "https://www.imdb.com/title/" + (movie?.imdb ?? ""), range: NSRange(location: 0, length: 4))
        let boldFont = UIFont(name: "Helvetica-bold", size: 16.0) as Any
        attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 0, length: 4))
        imdb.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        imdb.attributedText = attributedString
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.reloadData()
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

}

