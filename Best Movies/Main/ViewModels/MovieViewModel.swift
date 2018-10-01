//
//  MovieViewModel.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol MovieProtocol: class {
    func didGetResultFromApiCall(error: String?, login: ApiResults?)
    func didFailToParseData(error: String)
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
            result.results.sorted(by: { $0.popularity > $1.popularity })
            
        } catch let error {
            self.delegate?.didFailToParseData(error: error.localizedDescription)
        }
        
    }
    
    // Here we conform to Request Delegate and get data from request
    func didFinishRequest(data: Data?, error: Error?) {
        if error != nil {
            self.delegate?.didGetResultFromApiCall(error: error?.localizedDescription, login: nil)
        }
        parseData(data: data!)
//        self.delegate?.didGetResultFromApiCall(error: nil, login: data!)
    }
}
