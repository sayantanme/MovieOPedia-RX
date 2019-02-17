//
//  TrendingListCell.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 08/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class TrendingListCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieAvgVotes: UILabel!
    @IBOutlet weak var movieTotVotes: UILabel!
    //@IBOutlet weak var movieSummary: UILabel!
    @IBOutlet weak var containView: UIView!
    var dropShadowLayer: CAShapeLayer?
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var accView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.layer.insertSublayer(, at: 0)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviePoster.layer.cornerRadius = 6
        moviePoster.clipsToBounds = true
        
        accView.layer.cornerRadius = 2
        accView.clipsToBounds = true
        
        if let dSL = dropShadowLayer{
            dSL.removeFromSuperlayer()
        }
        dropShadowLayer = containView.dropShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(trendingItem:Items?){
        if let item = trendingItem,let backdropUrl = item.backdrop_path{
            
            moviePoster.loadImageFromImageUrlFromCache(url: backdropUrl)
            movieTitle.text = item.title
            movieAvgVotes.text = "\(item.vote_average)"
            movieTotVotes.text = "\(item.vote_count) votes"
            //movieSummary.text = trendingItem.overview
            releaseDate.text = "Release Date: \(item.releaseDate)"
        }
    }
}
