//
//  DetailsViewmodel.swift
//  Best Movies
//
//  Created by Fabio Dantas on 02/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol DetailsProtocol: class {
    func didFailToParseData(error: String)
    func requestDidFail(error: String)
    func didGetData(data: MovieDetail)
}


class DetailsViewModel: RequestDelegate {
    
    weak var delegate: DetailsProtocol?
    var request =  Request()
    
    init() {
        request.delegate = self
    }
    
    func fetchMovieDetails(endPoint: EndPoint) {
        guard let url = endPoint.url else {return}
        request.beginGetRequest(url: url)
    }
}


extension DetailsViewModel {
    // Here we conform to Request Delegate and get data from request
    
    private func parseData(data: Data) {
        do {
            let result = try JSONDecoder().decode(MovieDetail.self, from: data)
            self.delegate?.didGetData(data: result)
        
        } catch let error {
            self.delegate?.didFailToParseData(error: error.localizedDescription)
        }
    }
    
    func didFinishRequest(data: Data?, error: Error?) {
        if error != nil {
            self.delegate?.requestDidFail(error: error?.localizedDescription ?? "")
        }
        parseData(data: data!)
    }
}
