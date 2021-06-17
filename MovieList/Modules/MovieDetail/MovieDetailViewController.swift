//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by cevhersirin on 17.06.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var selectedMovie: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = selectedMovie {
            print(movie)
        }
    }
    
}
