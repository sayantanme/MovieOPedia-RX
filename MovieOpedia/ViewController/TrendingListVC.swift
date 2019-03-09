//
//  ViewController.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 06/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingListVC: UIViewController,UITableViewDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tblTrendingList: UITableView!
    var trendingListVM = TrendingListVM()
    var trends: TrendingViewDS?
    let disBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trends = TrendingViewDS(trendingVM: trendingListVM, vc: self)
        self.tblTrendingList.dataSource = trends
        self.tblTrendingList.prefetchDataSource = trends
        //trendingListVM.trendingListFetchFinished = trendingFetchDone
        trendingListVM.getTrendingMovies()
        
        
        trendingListVM.movieItems.asObservable().subscribe(onNext: { (movies) in
            DispatchQueue.main.async {
                self.tblTrendingList.reloadData()
            }
        })
        .disposed(by: disBag)
                
    }

    func trendingFetchDone(_ items:[Items]){
        DispatchQueue.main.async {
            
            self.tblTrendingList.reloadData()
            
        }
    }
    
    fileprivate func visibleIndexPathsToReload(intersecting ipaths:[IndexPath])->[IndexPath]{
        let iPathForVisibleRows = tblTrendingList.indexPathsForVisibleRows ?? []
        let iPathIntersection = Set(iPathForVisibleRows).intersection(ipaths)
        return Array(iPathIntersection)
    }
    
    //MARK: - Filter
    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = self
        pvc.view.backgroundColor = UIColor.red
        
        present(pvc, animated: true, completion: nil)
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}

class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = self.containerView else {
                return CGRect.zero
            }
            
            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
}


