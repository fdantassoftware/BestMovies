//
//  MovieViewModel.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol MovieProtocol: class {
    func didFailToParseData(error: String)
    func requestDidFail(error: String)
    func didGetData(data: ApiResults)
}

class MovieViewModel: RequestDelegate {
    
    weak var delegate: MovieProtocol?
    var request =  Request()
    
    init() {
        request.delegate = self
    }
    
    func fetchMovies(endPoint: EndPoint) {
        // Here we make our network request
        guard let url = endPoint.url else {return}
        request.beginGetRequest(url: url)
    }
    
}

extension MovieViewModel {
    
    // Here we parse our data using Decodable protocol. Notice that we are only parsing the data we need/
    private func parseData(data: Data) {
        do {
            let result = try JSONDecoder().decode(ApiResults.self, from: data)
            // Here we sort our array of movies by popularity
            result.results = result.results.sorted(by: { $0.popularity > $1.popularity })
            self.delegate?.didGetData(data: result)
            
        } catch let error {
            self.delegate?.didFailToParseData(error: error.localizedDescription)
        }
    }
    
    // Here we conform to Request Delegate and get data from request
    func didFinishRequest(data: Data?, error: Error?) {
        if error != nil {
            self.delegate?.requestDidFail(error: error?.localizedDescription ?? "")
        }
        parseData(data: data!)
    }
}
