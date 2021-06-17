//
//  BaseViewController.swift
//  MovieList
//
//  Created by cevhersirin on 16.06.2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var topNavBar: TopNavBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if topNavBar != nil {
            topNavBar.backButtonAction = {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
