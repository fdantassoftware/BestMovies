//
//  Movie.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let id: Int
    let poster_path: String?
    let backdrop_path: String?
    let title: String
    var release_date: String
    var popularity: Double
    let overview: String
}
