//
//  ViewController.swift
//  MovieList
//
//  Created by cevhersirin on 14.06.2021.
//

import UIKit
import SDWebImage

class ViewController: BaseViewController{
    
    let viewModel = DashboardViewModel()
    var moviesList = [Result]()
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var page = 1
    var isLoadingList = false
    var isSearchedJustNow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getMovieList()
        self.setStyle()
        self.setCollectionView()
        
        
    }
    func setStyle(){
        self.topNavBar.setTitle("Dashboard")
        self.topNavBar.hideBackButton()
    }
    func getMovieList() {
        viewModel.getMovies(page: self.page).subscribe(onNext: { (response: Movie) in
            
            print(response)
            self.moviesList += response.results
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                
                self.isLoadingList = false
                self.isSearchedJustNow = true
            }
            
            
            
        }).disposed(by: viewModel.disposeBag)
    }
    
    func setCollectionView(){
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        
        let cell = UINib(nibName: "MovieCollectionCell", bundle: nil)
        moviesCollectionView.register(cell, forCellWithReuseIdentifier: "MovieCollectionCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        moviesCollectionView.setCollectionViewLayout(layout, animated: true)
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.lblTitle.text = moviesList[indexPath.row].originalTitle
        if moviesList[indexPath.row].voteAverage == 0 {
            cell.lblAverage.text = "-"
        } else {
            cell.lblAverage.text = String(format: "%.1f", moviesList[indexPath.row].voteAverage)
        }
        if let posterPath = moviesList[indexPath.row].posterPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")
            cell.movieImage.sd_setImage(with: imageUrl, placeholderImage:nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 30) / 2
        return CGSize(width:width, height:250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.Storyboards.DetailScreen.instantiateInitialViewController() as! MovieDetailViewController
        detailVC.selectedMovie = moviesList[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList && !isSearchedJustNow){
            self.isLoadingList = true
            self.page += 1
            self.getMovieList()

        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isSearchedJustNow = false
    }
}
