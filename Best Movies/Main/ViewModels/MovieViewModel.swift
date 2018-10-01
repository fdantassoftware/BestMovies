//
//  MovieViewModel.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol MovieProtocol: class {
    func didGetResultFromLogin(error: String?, login: ApiResults?)
}

class MovieViewModel: RequestDelegate {
    
    weak var delegate: MovieProtocol?
    var request =  Request()
    
    init() {
        request.delegate = self
    }
    
    func fetchMovies(endPoint: EndPoint) {
        print(endPoint.parameters)
    }
    
}

extension MovieViewModel {
    
    // Here we conform to Request Delegate and get data from request
    func didFinishRequest(data: Data?, error: Error?) {
        
    }
}
