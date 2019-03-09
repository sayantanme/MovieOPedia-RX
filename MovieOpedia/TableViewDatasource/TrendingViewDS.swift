//
//  TrendingViewDS.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 13/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class TrendingViewDS: NSObject,UITableViewDataSource,UITableViewDataSourcePrefetching {
    
    private var trendingListVM: TrendingListVM?
    weak var vc:UIViewController?
    init(trendingVM: TrendingListVM,vc:UIViewController){
        trendingListVM = trendingVM
        self.vc = vc
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(trendingListVM?.trendingList.count ?? 0)
        return trendingListVM?.totalPages ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingListCell") as! TrendingListCell
        
        if isLoadingCell(for: indexPath){
            cell.setup(trendingItem: .none)
        }else{
            cell.setup(trendingItem:
                trendingListVM?.movieItems.value[indexPath.row])
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(indexPaths)
        if indexPaths.contains(where: isLoadingCell){
            
            if vc is TrendingListVC{
                trendingListVM?.getTrendingMovies()
            }else if vc is HindiMoviesVC{
                trendingListVM?.getTrendingHindiMovies()
            }
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= trendingListVM!.movieItems.value.count
    }
}
