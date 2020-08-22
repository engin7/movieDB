//
//  NowPlayingDS.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit

class NowPlayingDataSource: NSObject, UICollectionViewDataSource {

    private let network = NetworkManager.shared
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return network.upcomingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NowPlayingCollectionViewCell
            
            cell.title.text = network.upcomingMovies[indexPath.row].title
            
             return cell
        }
    
    
    }



