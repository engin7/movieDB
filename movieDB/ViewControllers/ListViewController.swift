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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
        upcomingMovies.dataSource =  tableViewDataSource
        nowPlayingMovies.dataSource = collectionViewDataSource
        
        dots.pageIndicatorTintColor = .systemGray5
        dots.currentPageIndicatorTintColor = .blue

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
        

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (nowPlayingMovies.contentOffset.x / nowPlayingMovies.frame.width)
            .rounded(.toNearestOrAwayFromZero)
        )
    }
    
    
}

