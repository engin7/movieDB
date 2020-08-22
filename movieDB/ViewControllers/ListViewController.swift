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

class ListViewController: UIViewController {

    @IBOutlet weak var upcomingMovies: UITableView!
    
    @IBOutlet weak var nowPlayingMovies: UICollectionView!
    
    private let tableViewDataSource = UpcomingMoviesDataSource()
    private let collectionViewDataSource = NowPlayingDataSource()
    
    private let network = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
        upcomingMovies.dataSource =  tableViewDataSource
        nowPlayingMovies.dataSource = collectionViewDataSource
        
        
        network.upcomingMovies(completion: {success in
            if success {
                self.upcomingMovies.reloadData()
                self.nowPlayingMovies.reloadData()

             }
        })

    }

    
    
}

