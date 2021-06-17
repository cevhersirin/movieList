//
//  MovieCollectionCell.swift
//  MovieList
//
//  Created by cevhersirin on 16.06.2021.
//

import Foundation
import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var viewTitle: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}
