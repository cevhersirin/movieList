//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by cevhersirin on 19.06.2021.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel: BaseViewModel {
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetail> {
        
        return Observable.create { (observer: AnyObserver<MovieDetail>) -> Disposable in
            MovieAPI.moviesDetail(movieId: movieId) { (response:MovieDetail?) in
                if let res = response {
                    observer.onNext(res)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
