//
//  SimilarMoviesDS.swift
//  movieDB
//
//  Created by Engin KUK on 24.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit

class SimilarMoviesDataSource: NSObject, UICollectionViewDataSource {
    
    private let network = NetworkManager.shared
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return network.similarMovies.count
       }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimilarMoviesViewCell
        
        cell.label.text = network.similarMovies[indexPath.row].title
        
        let imageURL = URL(string: "http://image.tmdb.org/t/p/w92" + network.nowplayingMovies[indexPath.row].posterImagePath)
        cell.image.kf.setImage(with: imageURL)
        
        return  cell
        
    }
}

