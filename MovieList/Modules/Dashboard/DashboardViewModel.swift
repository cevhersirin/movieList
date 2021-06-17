//
//  DashboardViewModel.swift
//  MovieList
//
//  Created by cevhersirin on 17.06.2021.
//

import Foundation
import RxCocoa
import RxSwift

class DashboardViewModel: BaseViewModel {
    
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

