//
//  API.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class API {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var endPoint: String
    
    init(endPoint: EndPoint) {
        self.endPoint = endPoint.rawValue
    }
    
}

// Here we we can add more endpoints if necessary

enum EndPoint: String {
    case latest = "latest"
    case nowPlaying = "now_playing"
    case popular = "popular"
    
}
