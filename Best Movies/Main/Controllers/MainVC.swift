//
//  MainVC.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let cellID = "MovieCell"
    var movies = [Movie]()
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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor().setRGB(r: 205, g: 229, b: 241)
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var movieViewModel = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellID)
        movieViewModel.delegate = self
        movieViewModel.fetchMovies(endPoint: .popular(page: 1, language: "en-US"))
        view.addSubview(topView)
        view.addSubview(collectionView) 
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
        
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
    }

}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MovieCell {
            let movie = movies[indexPath.row]
            cell.configureCell(movie: movie)
            cell.backgroundColor = UIColor.black
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 178, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
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
        DispatchQueue.main.async {
            self.movies = data.results
            self.collectionView.reloadData()
        }
    }
   
}
