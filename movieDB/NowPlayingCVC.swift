//
//  NowPlayingCVC.swift
//  movieDB
//
//  Created by Engin KUK on 22.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation

import UIKit
class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            self.contentView.isUserInteractionEnabled = true
        }

    override func prepareForReuse() {
        super.prepareForReuse()
       
    }
    
    
}
