//
//  ApiResults.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class ApiResults: Decodable {
    let page: Int
    let numResults: Int
    let numPages: Int
    let movies: [Movie]
}
