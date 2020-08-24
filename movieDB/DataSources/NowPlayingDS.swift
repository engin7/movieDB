//
//  NowPlayingDS.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit
import Kingfisher

class NowPlayingDataSource: NSObject, UICollectionViewDataSource {

    private let network = NetworkManager.shared
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return network.nowplayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NowPlayingCollectionViewCell
        
        cell.title.text = network.nowplayingMovies[indexPath.row].title
        cell.title.adjustsFontSizeToFitWidth = true
        
        var imageURL: URL?
        if network.nowplayingMovies[indexPath.row].backdropImagePath != nil {
        imageURL = URL(string: "http://image.tmdb.org/t/p/w300" + network.nowplayingMovies[indexPath.row].backdropImagePath!)
        } else {
            imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + network.nowplayingMovies[indexPath.row].posterImagePath)
        }
     
        cell.image.kf.setImage(with: imageURL)

        return cell
    }
    
    
    }



