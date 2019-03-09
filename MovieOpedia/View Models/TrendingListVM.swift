//
//  TrendingListVM.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 07/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TrendingListVM {
    
    var currentPage = 1
    var totalPages = 0
    
    let bag = DisposeBag()
    let movieItems = BehaviorRelay<[Items]>(value: [])
    
    func getTrendingMovies(){
        let url = "https://api.themoviedb.org/3/trending/all/day?api_key=02774a8dc709916083e34ab3c8ee9bd4&page="

        getMoviesFrom(url: url)
    }
    
    func getTrendingHindiMovies(){
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=02774a8dc709916083e34ab3c8ee9bd4&region=IN&language=hi-IN&with_original_language=hi&page="
        
        getMoviesFrom(url: url)
    }
    
    fileprivate func getMoviesFrom(url: String){

        let response = Observable.from([url])
            .map { (urlString) -> URL in
                return URL(string: "\(url)\(self.currentPage)")!
            }
            .distinctUntilChanged()
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { request -> Observable<(response:HTTPURLResponse, data:Data)> in
                return URLSession.shared.rx.response(request: request)
            }

        response
            .filter { (response, data)  in
                return 200..<300 ~= response.statusCode
            }.map { data -> TrendingList in
                //let fData = data.data.fla
                return try! JSONDecoder().decode(TrendingList.self, from: data.data)
            }.map{ trends -> [Items] in
                self.totalPages = trends.total_pages
                return trends.results.filter{!($0.title.isEmpty)}
                
            }
            .subscribe(onNext: { (items) in
                self.currentPage += 1
                
                self.assignItems(tends: items)
            })
            .disposed(by: bag)
    }
    
    fileprivate func assignItems(tends: [Items]){
        movieItems.accept(movieItems.value + tends)
    }
}
