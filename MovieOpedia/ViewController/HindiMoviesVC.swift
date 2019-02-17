//
//  HindiMoviesVC.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 16/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class HindiMoviesVC: UIViewController {

    @IBOutlet weak var tblHindiMovies: UITableView!
    var trendingListVM = TrendingListVM()
    var trends: TrendingViewDS?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trends = TrendingViewDS(trendingVM: trendingListVM, vc: self)
        self.tblHindiMovies.dataSource = trends
        self.tblHindiMovies.prefetchDataSource = trends
        trendingListVM.trendingListFetchFinished = trendingFetchDone
        trendingListVM.getTrendingHindiMovies()
    }
    

    func trendingFetchDone(_ items:[Items], _ indexPaths:[IndexPath]?){
        DispatchQueue.main.async {
            guard let _ = indexPaths else{
                self.tblHindiMovies.reloadData()
                return
            }
            
//            let iPathToBeReloaded = self.visibleIndexPathsToReload(intersecting: newIndexPaths)
//            self.tblHindiMovies.reloadRows(at: iPathToBeReloaded, with: .none)
        }
    }
    
    fileprivate func visibleIndexPathsToReload(intersecting ipaths:[IndexPath])->[IndexPath]{
        let iPathForVisibleRows = tblHindiMovies.indexPathsForVisibleRows ?? []
        let iPathIntersection = Set(iPathForVisibleRows).intersection(ipaths)
        return Array(iPathIntersection)
    }

}
