//
//  API.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class API {
    
    // We could store the api key more securely however for simplicity lets put it here
    static let apiKey = "44cea07f0c8fe55ce96d9c3204aa387c"
}



enum EndPoint {
    // If we need to add another endpoint we just need to create a new case and pass however we need to the enum ex page, language etc
    case popular(page: Int, language: String)
    case genres(language: String)
    private var baseURL: String {
        var url = "api.themoviedb.org"
        return url
        
    }
    
    // here we build our url easily using URLComponents according to the end point we want
    var url: URL? {
        switch self {
        case .popular(let page, let language):
            var url = URLComponents()
            url.scheme = "https";
            url.host = baseURL;
            url.path = "/3/movie/popular";
            url.queryItemsDictionary = ["api_key": API.apiKey, "language":language, "page": page]
            return url.url
        case .genres(let language):
            var url = URLComponents()
            url.scheme = "https";
            url.host = baseURL;
            url.path = "/3/genre/movie/list";
            url.queryItemsDictionary = ["api_key": API.apiKey, "language":language]
            return url.url
        }
    }
  
}
