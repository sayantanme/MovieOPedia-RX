//
//  TrendingList.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 07/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import Foundation

struct TrendingList: Codable{
    let page: Int
    let results:[Items]
    let total_pages:Int
    let total_results:Int
    enum CodingKeys: String,CodingKey{
        case page
        case results
        case total_pages
        case total_results
    }
    
    init(from decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode(Array<Items>.self, forKey: .results)
        total_results = try values.decode(Int.self, forKey: .total_results)
        total_pages = try values.decode(Int.self, forKey: .total_pages)
    }
}

struct Items:Codable{
    let posterPath:String
    let isAdult:Bool
    let overview:String
    let releaseDate:String
    let genre_ids : [Int]?
    let id:Int
    let original_title:String
    let original_language:String
    let title:String
    let backdrop_path:String?
    let popularity:Double
    let vote_count:Int
    let video:Bool
    let vote_average:Double
    
    
    enum CodingKeys: String,CodingKey{
        case posterPath = "poster_path"
        case isAdult = "adult"
        case overview
        case releaseDate = "release_date"
        case genre_ids
        case id
        case original_title
        case original_language
        case title
        case backdrop_path
        case popularity
        case vote_count
        case video
        case vote_average
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            posterPath = try "https://image.tmdb.org/t/p/w1280" + values.decode(String.self, forKey: .posterPath)
        }catch{
            posterPath = ""
        }
        do{
            isAdult = try values.decode(Bool.self, forKey: .isAdult)
        }catch{
            isAdult = false
        }
        do{
            overview = try values.decode(String.self, forKey: .overview)
        }catch{
            overview = ""
        }
        do{
            releaseDate = try values.decode(String.self, forKey: .releaseDate)
        }catch{
            releaseDate = ""
        }
        genre_ids = try values.decodeIfPresent(Array<Int>.self, forKey: .genre_ids)
        id = try values.decode(Int.self, forKey: .id)
        do{
            original_title = try values.decode(String.self, forKey: .original_title)
        }catch{
            original_title = ""
        }
        do{
            original_language = try values.decode(String.self, forKey: .original_language)
        }catch{
            original_language = ""
        }
        do{
            title = try values.decode(String.self, forKey: .title)
        }catch{
            title = ""
        }
        if let bPath = try values.decodeIfPresent(String.self, forKey: .backdrop_path){
            backdrop_path = "https://image.tmdb.org/t/p/w500" + bPath
        }else{
            backdrop_path = nil
        }
        do{
            popularity = try values.decode(Double.self, forKey: .popularity)
        }catch{
            popularity = 0.0
        }
        
        do{
            vote_count = try values.decode(Int.self, forKey: .vote_count)
        }catch{
            vote_count = 0
        }
        do{
            video = try values.decode(Bool.self, forKey: .video)
        }catch{
            video = false
        }
        do{
            vote_average = try values.decode(Double.self, forKey: .vote_average)
        }catch{
            vote_average = 0.0
        }
    }
}
