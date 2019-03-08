//
//  HindiMoviesVC.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 16/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import UIKit
import RxSwift

class HindiMoviesVC: UIViewController {

    @IBOutlet weak var tblHindiMovies: UITableView!
    var trendingListVM = TrendingListVM()
    var trends: TrendingViewDS?
    let disbag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trends = TrendingViewDS(trendingVM: trendingListVM, vc: self)
        self.tblHindiMovies.dataSource = trends
        self.tblHindiMovies.prefetchDataSource = trends
        //trendingListVM.trendingListFetchFinished = trendingFetchDone
        trendingListVM.getTrendingHindiMovies()
        
        trendingListVM.events.asObservable().subscribe(onNext: { (movies) in
            DispatchQueue.main.async {
                self.tblHindiMovies.reloadData()
            }
        })
        .disposed(by: disbag)
        
    }
    

    func trendingFetchDone(_ items:[Items]){
        DispatchQueue.main.async {

            self.tblHindiMovies.reloadData()
            

        }
    }
    
    fileprivate func visibleIndexPathsToReload(intersecting ipaths:[IndexPath])->[IndexPath]{
        let iPathForVisibleRows = tblHindiMovies.indexPathsForVisibleRows ?? []
        let iPathIntersection = Set(iPathForVisibleRows).intersection(ipaths)
        return Array(iPathIntersection)
    }

}
