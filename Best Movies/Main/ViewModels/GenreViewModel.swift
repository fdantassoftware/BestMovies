//
//  GenreViewModel.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class GenreViewModel: RequestDelegate {
    
    var request =  Request()
    
    init() {
        request.delegate = self
    }

    func fetchGenres(endPoint: EndPoint) {
        guard let url = endPoint.url else {return}
        print(url)
        request.beginGetRequest(url: url)
    }
    
}

extension GenreViewModel {
    
    private func parseData(data: Data) {
        do {
            let result = try JSONDecoder().decode(GenreResults.self, from: data)
            // Here we sort our array of movies by popularity
            GenreHelper.shared.genres = result.genres
        } catch let error {
            print(error)
        }
    }
    
    func didFinishRequest(data: Data?, error: Error?) {
        if error != nil {
            print(error?.localizedDescription)
        }
        parseData(data: data!)
    }
}
