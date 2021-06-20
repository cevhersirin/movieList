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
    var movieGenres = [Genre]()
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var viewStatus: MovieInfoView!
    @IBOutlet weak var viewAverage: MovieInfoView!
    @IBOutlet weak var viewRuntime: MovieInfoView!
    @IBOutlet weak var viewReleaseDate: MovieInfoView!
    
    @IBOutlet weak var collectionGenres: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStyle()
        self.getMovieDetail()
        self.collectionGenres.delegate = self
        self.collectionGenres.dataSource = self
        
        let cellGenre = UINib(nibName: "GenreCollectionViewCell", bundle: nil)
        collectionGenres.register(cellGenre, forCellWithReuseIdentifier: "GenreCollectionViewCell")
        

    }
    
    func setStyle(){
        self.topNavBar.setTitle(self.selectedMovie?.title ?? "Movie Detail")
        self.topNavBar.dropShadow()
    }
    
    func getMovieDetail(){
        viewModel.getMovieDetails(movieId: (self.selectedMovie?.id)!).subscribe(onNext: { (response: MovieDetail) in
            
            self.movieDetailItem = response
            if let genres = response.genres {
                self.movieGenres = genres
                DispatchQueue.main.async {
                    self.collectionGenres.reloadData()
                }
            }
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
            self.viewRuntime.setValues(title: "Run Time:", value: String(runtime) + " min")
        } else {
            self.viewRuntime.setValues(title: "Run Time:", value: "Unknown")
        }
        self.viewReleaseDate.setValues(title: "Status:", value: self.movieDetailItem?.releaseDate ?? "Unknown")
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movieGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        cell.setValue(value: self.movieGenres[indexPath.row].name!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {


        let totalCellWidth = 100 * self.movieGenres.count
        let totalSpacingWidth = 10 * (self.movieGenres.count - 1)

        let leftInset = (self.collectionGenres.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        if leftInset > 0 {
            return UIEdgeInsets(top: 5, left: leftInset, bottom: 5, right: rightInset)
        } else {
            return UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        }
        
    }
    
    
}
