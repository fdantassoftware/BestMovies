//
//  MovieDetail.swift
//  Best Movies
//
//  Created by Fabio Dantas on 02/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class MovieDetail: Decodable {
    
    let backdrop_path: String?
    let overview: String?
    let runtime: Int?
    let revenue: Int
    let original_language: String
    let homepage: String?
}
