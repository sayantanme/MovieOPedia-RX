//
//  TrendingListVM.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 07/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import Foundation

class TrendingListVM {
    
    var batchSize : Int?
    var trendingList = [Items]()
    var trendingListFetchFinished : ((_ list:[Items],_ indexPaths:[IndexPath]?)->())?
    var currentFetchedTrendingList: TrendingList?
    var isFetchInProgress = false
    var currentPage = 1
    var totalPages = 0
    
    func getTrendingList(url: String,_ completion:@escaping (TrendingList?) -> ()){
        guard !isFetchInProgress else{
            return
        }
        isFetchInProgress = true
        if let url = URL(string: "\(url)\(self.currentPage)"){
            print(url)
            let movieRes = Resource<TrendingList>(url:url)
            NetworkQueries().getList(movieRes) { (movies) in
                if let res = movies{
                    self.currentPage += 1
                    self.totalPages = res.total_results
                    self.trendingList.append(contentsOf: res.results)
                    
                    if res.page > 1{
                        let indexPathsToBeReloaded = self.calculateIndexpathsToBeReloaded(res.results)
                        self.trendingListFetchFinished?(res.results,indexPathsToBeReloaded)
                    }else{
                        self.trendingListFetchFinished?(res.results,.none)
                    }
                }
                self.isFetchInProgress = false
            }
        }
    }
    
    private func calculateIndexpathsToBeReloaded(_ newList:[Items])->[IndexPath]{
        let startIndex = trendingList.count - newList.count
        let endIndex = startIndex + newList.count
        return (startIndex..<endIndex).map{IndexPath(row: $0, section: 0)}
    }
    
    func getTrendingMovies(){
        let url = "https://api.themoviedb.org/3/trending/all/day?api_key=02774a8dc709916083e34ab3c8ee9bd4&page="
        self.getTrendingList(url: url){ (list) in
            //print(list)
        }
    }
    
    func getTrendingHindiMovies(){
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=02774a8dc709916083e34ab3c8ee9bd4&region=IN&language=hi-IN&with_original_language=hi&page="
        self.getTrendingList(url: url){ (list) in
            //print(list)
        }
    }
}


//https://api.themoviedb.org/3/discover/movie?api_key=02774a8dc709916083e34ab3c8ee9bd4&region=IN&language=hi-IN&with_original_language=hi


//&release_date.gte=2017-08-01&with_release_type=3|2
