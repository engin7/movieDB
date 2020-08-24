//
//  ViewController.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

//* Slider’s data should getted from “/movie/now_playing”.
//* Other data should getted from “/movie/upcoming”.


import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {

    @IBOutlet weak var upcomingMovies: UITableView!
    @IBOutlet weak var nowPlayingMovies: UICollectionView!
    @IBOutlet weak var dots: UIPageControl!
    
    private let tableViewDataSource = UpcomingMoviesDataSource()
    private let collectionViewDataSource = NowPlayingDataSource()
    private let network = NetworkManager.shared
    var searchController: UISearchController!
    private var resultsTableViewController: SearchViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        upcomingMovies.dataSource =  tableViewDataSource
        nowPlayingMovies.dataSource = collectionViewDataSource
         
        network.getMovies(get: .upcoming, searchText: nil, movie: nil, completion: {success in
            if success {
                self.upcomingMovies.reloadData()
             }
        })
        
        network.getMovies(get: .nowplaying, searchText: nil, movie: nil, completion: {success in
            if success {
                self.nowPlayingMovies.reloadData()
                self.dots.numberOfPages = self.network.nowplayingMovies.count
            }
        })
        
        resultsTableViewController = storyboard!.instantiateViewController(withIdentifier: "resultsViewController") as? SearchViewController
        resultsTableViewController.delegate = self

        searchController = UISearchController(searchResultsController: resultsTableViewController)

        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (nowPlayingMovies.contentOffset.x / nowPlayingMovies.frame.width)
            .rounded(.toNearestOrAwayFromZero)
        )
    }
    
// TODO:- Refactor Network functions
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nowPlaying = network.nowplayingMovies[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! MovieDetailViewController
        
         network.getMovies(get: .similar, searchText: nil, movie: nowPlaying, completion: {success in
             if success {
              vc.similarMovies = self.network.similarMovies
             }
         })
        
        network.getMovies(get: .byId, searchText: nil, movie: nowPlaying, completion: {success in
                       if success {
                        vc.movie = self.network.movieById!
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                       }
                   })

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let result = NetworkManager.shared.upcomingMovies[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! MovieDetailViewController
        
        network.getMovies(get: .similar, searchText: nil, movie: result, completion: {success in
                   if success {
                    vc.similarMovies = self.network.similarMovies
                   }
               })
        
         network.getMovies(get: .byId, searchText: nil, movie: result, completion: {success in
            if success {
                vc.movie = self.network.movieById!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
        
       }
    
    // MARK:- Helper Methods
     
     func showNetworkError() {
       let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Movie DataBase. Please try again.", preferredStyle: .alert)
       
       let action = UIAlertAction(title: "OK", style: .default, handler: nil)
       alert.addAction(action)
       present(alert, animated: true, completion: nil)
       }
    
}

// MARK: - Extensions

extension ListViewController: UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        network.getMovies(get: .search, searchText: searchBar.text!, movie: nil, completion: {success in
            
            if !success {
                self.showNetworkError()
            } else {
                self.resultsTableViewController.tableView.reloadData()
            }
        })
    }
    
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.network.searchedMovies = []
  }
}

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text!.count < 3 {
            searchController.showsSearchResultsController = false
        } else {
            searchController.showsSearchResultsController = true
        }
    }
}

extension ListViewController: SearchViewControllerDelegate {
func pushVC(result: Movie) {
      let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! MovieDetailViewController
    
    network.getMovies(get: .similar, searchText: nil, movie: result, completion: {success in
                      if success {
                       vc.similarMovies = self.network.similarMovies
                      }
                  })
    
     network.getMovies(get: .byId, searchText: nil, movie: result, completion: {success in
        if success {
            vc.movie = self.network.movieById!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    })    }
}
