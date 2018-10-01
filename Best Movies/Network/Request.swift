//
//  Request.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

// Protocol to handle result of request

protocol RequestDelegate: class {
    func didFinishRequest(data: Data?, error: Error?)
}

class Request {
    
    weak var delegate: RequestDelegate?
    
    func beginGetRequest(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFinishRequest(data: nil, error: error)
            }
            guard let data = data else { return }
            self.delegate?.didFinishRequest(data: data, error: nil)
        }.resume()
    }
    
}
