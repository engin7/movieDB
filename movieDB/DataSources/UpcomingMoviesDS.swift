//
//  upcomingMoviesDataSource.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation
import UIKit

class UpcomingMoviesDataSource: NSObject, UITableViewDataSource {
    
    private let network = NetworkManager.shared

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return network.upcomingMovies.count
    
        }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpcomingMoviesTableViewCell
        
        cell.title.text = network.upcomingMovies[indexPath.row].title
        cell.detail.text = network.upcomingMovies[indexPath.row].overview
        cell.date.text = network.upcomingMovies[indexPath.row].release_date
        
        let imageURL = URL(string: "http://image.tmdb.org/t/p/w92" + network.upcomingMovies[indexPath.row].posterImagePath)
        cell.imageUpcoming.kf.setImage(with: imageURL)
            
        return  cell
    }
}


 
