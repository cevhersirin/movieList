//
//  GenreCollectionViewCell.swift
//  MovieList
//
//  Created by cevhersirin on 20.06.2021.
//

import Foundation
import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblGenre: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setValue(value: String){
        self.lblGenre.text = value
    }
    
    
}
