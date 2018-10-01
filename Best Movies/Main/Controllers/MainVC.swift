//
//  MainVC.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().setRGB(r: 12, g: 26, b: 86)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topViewTitle: UIView = {
        let label = UILabel()
        label.text = "Best Movies"
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var model = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.fetchMovies(endPoint: .popular(page: 1, language: "en-US"))
        view.addSubview(topView)
        topView.addSubview(topViewTitle)
        configureConstraints()
    
    }
    
    func configureConstraints() {
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topViewTitle.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topViewTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        topViewTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        topViewTitle.topAnchor.constraint(equalTo: topView.topAnchor, constant: 40).isActive = true
    }

}

extension MainVC: MovieProtocol {
    
    func requestDidFail(error: String) {
        print(error)
    }
    
    func didFailToParseData(error: String) {
        // Data
        print(error)
    }
    
    func didGetData(data: ApiResults) {
        // Here we have our data ready
    }
   
}
