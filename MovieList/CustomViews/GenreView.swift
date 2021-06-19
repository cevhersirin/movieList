//
//  GenreView.swift
//  MovieList
//
//  Created by cevhersirin on 20.06.2021.
//

import Foundation
import UIKit

class GenreView: UIView {
    @IBOutlet weak var lblGenre: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        ownFirstNib()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        ownFirstNib()
    }
    
    func setValue(value: String){
        self.lblGenre.text = value
    }
    
    
}
