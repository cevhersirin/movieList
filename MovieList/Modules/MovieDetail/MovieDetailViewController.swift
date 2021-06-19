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
    let viewModel = MovieDetailViewModel()
    var movieDetailItem: MovieDetail?
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var viewStatus: MovieInfoView!
    @IBOutlet weak var viewAverage: MovieInfoView!
    @IBOutlet weak var viewRuntime: MovieInfoView!
    @IBOutlet weak var viewReleaseDate: MovieInfoView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStyle()
        self.getMovieDetail()
        
        
        
        if let myImage = imageBackdrop.image {
            let myImageHeight = myImage.size.height
            self.imageHeight.constant = myImageHeight
        }

    }
    
    func setStyle(){
        self.topNavBar.setTitle(self.selectedMovie?.title ?? "Movie Detail")
        self.topNavBar.dropShadow()
    }
    
    func getMovieDetail(){
        viewModel.getMovieDetails(movieId: (self.selectedMovie?.id)!).subscribe(onNext: { (response: MovieDetail) in
            
            self.movieDetailItem = response
            DispatchQueue.main.async {
                self.setDatas()
            }
            
        }).disposed(by: viewModel.disposeBag)
    }
    
    func setDatas(){
        if let posterPath = selectedMovie?.backdropPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w400\(posterPath)")
            imageBackdrop.sd_setImage(with: imageUrl, placeholderImage:nil)
        }
        
        self.txtTitle.text = self.movieDetailItem?.title
        self.txtOverview.text = self.movieDetailItem?.overview
        self.viewStatus.setValues(title: "Status:", value: self.movieDetailItem?.status ?? "Unknown")
        if let average = self.movieDetailItem?.voteAverage {
            self.viewAverage.setValues(title: "Vote Average:", value: String(average))
        } else {
            self.viewAverage.setValues(title: "Vote Average:", value: "Unknown")
        }
        if let runtime = self.movieDetailItem?.runtime {
            self.viewRuntime.setValues(title: "Run Time:", value: String(runtime) + "min")
        } else {
            self.viewRuntime.setValues(title: "Run Time:", value: "Unknown")
        }
        self.viewReleaseDate.setValues(title: "Status:", value: self.movieDetailItem?.releaseDate ?? "Unknown")
    }
    
}
