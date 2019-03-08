//
//  Resource.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 06/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import Foundation
struct Resource<A> where A:Codable {
    let url: URL
    let parseIt:(Data) -> A = { data in return try! JSONDecoder().decode(A.self, from: data)}
}
