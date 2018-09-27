//
//  Movie.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let id: Int!
    let posterPath: String?
    let videoPath: String?
    let backdrop: String
    let title: String
    var releaseData: String
    var rating: Double
    let overview: String
}
