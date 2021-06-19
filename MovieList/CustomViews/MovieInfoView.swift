//
//  MovieInfoView.swift
//  MovieList
//
//  Created by cevhersirin on 20.06.2021.
//

import Foundation
import UIKit

class MovieInfoView: UIView {
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtValue: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ownFirstNib()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        ownFirstNib()
    }
    
    func setValues(title: String, value: String){
        self.txtTitle.text = title
        self.txtValue.text = value
    }
}
