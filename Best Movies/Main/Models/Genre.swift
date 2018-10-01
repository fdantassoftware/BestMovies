//
//  Genre.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class Genre: Decodable {
    let id: Int
    let name: String
}

class GenreResults: Decodable {
    let genres: [Genre]
}


// Here we create a helper to save our genres data and use it later

class GenreHelper {
    
    static let shared: GenreHelper = {
        let instance = GenreHelper()
        return instance
    }()
    
    var genres = [Genre]()
}
