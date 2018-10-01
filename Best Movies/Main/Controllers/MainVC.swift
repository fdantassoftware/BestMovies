//
//  MainVC.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    var model = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.fetchMovies(endPoint: .popular(page: 1, language: "en-US"))
        // Do any additional setup after loading the view.
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainVC: MovieProtocol {
    
    func didFailToParseData(error: String) {
        // Data
    }
    
    func didGetResultFromApiCall(error: String?, login: ApiResults?) {
        
    }
   
    
}
