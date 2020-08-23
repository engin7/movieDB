//
//  SearchViewController.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

//* Search data should getted from “/search/movie”.
//* Search should start when user write more than two word to the search box.
//* User can go to the detail of the movie.


import UIKit

protocol SearchViewControllerDelegate: class {
    func pushVC(vc: UIViewController)
}

class SearchViewController: UITableViewController {
     
    weak var delegate: SearchViewControllerDelegate?

    override func viewDidLoad() {
      super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkManager.shared.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if
        let cell = tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as? UpcomingMoviesTableViewCell {
        let result = NetworkManager.shared.searchedMovies[indexPath.row]
        cell.textLabel?.text = result.title
        
        return cell
      }
      return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let result = NetworkManager.shared.searchedMovies[indexPath.row]
       let vc = MovieDetailViewController(movie: result)
        delegate?.pushVC(vc: vc)
    }
    
}
