//
//  SimilarMoviesCVC.swift
//  movieDB
//
//  Created by Engin KUK on 24.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import UIKit

class SimilarMoviesViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.adjustsFontSizeToFitWidth = true

    }
    
    
}
