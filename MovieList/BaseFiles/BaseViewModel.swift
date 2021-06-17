//
//  BaseViewModel.swift
//  MovieList
//
//  Created by cevhersirin on 14.06.2021.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    var disposeBag = DisposeBag()
    let baseURL = "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a"
    
    
    func getMovies(page: Int) -> Observable<Movie> {
        
        return Observable.create { (observer: AnyObserver<Movie>) -> Disposable in
            MovieAPI.movies(page: page) { (response:Movie?) in
                if let res = response {
                    observer.onNext(res)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    
    
    
}
