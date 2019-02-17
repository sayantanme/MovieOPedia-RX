//
//  ViewController.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 06/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class TrendingListVC: UIViewController {

    @IBOutlet weak var tblTrendingList: UITableView!
    var trendingListVM = TrendingListVM()
    var trends: TrendingViewDS?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trends = TrendingViewDS(trendingVM: trendingListVM, vc: self)
        self.tblTrendingList.dataSource = trends
        self.tblTrendingList.prefetchDataSource = trends
        trendingListVM.trendingListFetchFinished = trendingFetchDone
        trendingListVM.getTrendingMovies()
                
    }

    func trendingFetchDone(_ items:[Items], _ indexPaths:[IndexPath]?){
        DispatchQueue.main.async {
            guard let _ = indexPaths else{
                self.tblTrendingList.reloadData()
                return
            }
            
            //let iPathToBeReloaded = self.visibleIndexPathsToReload(intersecting: newIndexPaths)
            //self.tblTrendingList.reloadRows(at: iPathToBeReloaded, with: .none)
        }
    }
    
    fileprivate func visibleIndexPathsToReload(intersecting ipaths:[IndexPath])->[IndexPath]{
        let iPathForVisibleRows = tblTrendingList.indexPathsForVisibleRows ?? []
        let iPathIntersection = Set(iPathForVisibleRows).intersection(ipaths)
        return Array(iPathIntersection)
    }
}


