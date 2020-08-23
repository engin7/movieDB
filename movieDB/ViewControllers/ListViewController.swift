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

class ListViewController: UIViewController, UICollectionViewDelegate {

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
        
        dots.pageIndicatorTintColor = .darkGray
        dots.currentPageIndicatorTintColor = .white

        network.upcomingMovies(completion: {success in
            if success {
                self.upcomingMovies.reloadData()
                //change to nowplaying
            }
        })
        
        network.nowplayingMovies(completion: {success in
            if success {
                self.nowPlayingMovies.reloadData()
                self.dots.numberOfPages = self.network.nowplayingMovies.count
            }
        })
        
        resultsTableViewController = storyboard!.instantiateViewController(withIdentifier: "resultsViewController") as? SearchViewController
        
        searchController = UISearchController(searchResultsController: resultsTableViewController)

        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie"
        searchController.searchBar.delegate = self
        
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (nowPlayingMovies.contentOffset.x / nowPlayingMovies.frame.width)
            .rounded(.toNearestOrAwayFromZero)
        )
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
    
    network.performSearch(searchText: searchBar.text!, completion: {success in
    
              if !success {
                 self.showNetworkError()
              }
        self.resultsTableViewController.tableView.reloadData()
               })
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.network.searchedMovies = []
  }
}


 
