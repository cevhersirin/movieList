//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by cevhersirin on 17.06.2021.
//

import UIKit
import SDWebImage

class MovieDetailViewController: BaseViewController {

    var selectedMovie: Result?
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStyle()
        if let movie = selectedMovie {
            print(movie)
        }
        if let posterPath = selectedMovie?.backdropPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w400\(posterPath)")
            imageBackdrop.sd_setImage(with: imageUrl, placeholderImage:nil)
        }
        
        if let myImage = imageBackdrop.image {
            let myImageHeight = myImage.size.height
            
            self.imageHeight.constant = myImageHeight
        }

    }
    
    func setStyle(){
        self.topNavBar.setTitle(self.selectedMovie?.title ?? "Movie Detail")
    }
    
}

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}
