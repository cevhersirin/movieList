//
//  TopNavBar.swift
//  MovieList
//
//  Created by cevhersirin on 16.06.2021.
//

import Foundation
import UIKit

class TopNavBar: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    var backButtonAction:(() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ownFirstNib()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ownFirstNib()
        configure()
    }
    
    func configure(){
        
    }
    func setTitle(_ title: String) {
        self.lblTitle.text = title
    }
    
    func hideBackButton(){
        self.btnBack.isHidden = true
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        if backButtonAction != nil {
            self.backButtonAction!()
        }
    }
    
}
