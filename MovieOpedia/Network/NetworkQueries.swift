//
//  NetworkQueries.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 07/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import Foundation

struct NetworkQueries {
    
    func getList<A>(_ resource:Resource<A>, completion:@escaping (A?)->()){
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: resource.url) { (data, response, error) in
            guard error == nil else{
                completion(nil)
                return
            }
            
            guard !(data?.isEmpty)! else{
                completion(nil)
                return
            }
            
            if let resp = response as? HTTPURLResponse, resp.statusCode == 200{
                completion(data.flatMap(resource.parse))
            }
        }.resume()
    }
}
