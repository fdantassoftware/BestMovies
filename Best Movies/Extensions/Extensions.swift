//
//  Extensions.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation
import UIKit

// Get rgb color instead of typing /255 everytime
extension UIColor {
    func setRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

// Extension to get query string from dictionary
extension URLComponents{
    var queryItemsDictionary : [String:Any]{
        set (queryItemsDictionary){
            self.queryItems = queryItemsDictionary.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
        }
        get{
            var params = [String: Any]()
            return queryItems?.reduce([:], { (_, item) -> [String: Any] in
                params[item.name] = item.value
                return params
            }) ?? [:]
        }
    }
}
