//
//  MainVC.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    var filteredMovies = [Movie]()
    var isSearching = false
    var movies = [Movie]()
    
    
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
   
    var movieViewModel = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        movieViewModel.delegate = self
        movieViewModel.fetchMovies(endPoint: .popular(page: 1, language: "en-US"))
        // here we add a tap recognizer to the collectionView to allow for end editing
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        collectionView.addGestureRecognizer(tap)
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
 
}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            let movie: Movie
            if isSearching {
                movie = filteredMovies[indexPath.row]
            } else {
                movie = movies[indexPath.row]
            }
            cell.configureCell(movie: movie)
            cell.backgroundColor = UIColor.black
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        if isSearching {
            movie = filteredMovies[indexPath.row]
        } else {
           movie = movies[indexPath.row]
        }
        performSegue(withIdentifier: "showDetails", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let dest = segue.destination as? DetailsVC {
                if let movie = sender as? Movie {
                    dest.movie = movie
                }
            }
        }
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




extension MainVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.view.endEditing(true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text?.isEmpty)! {
            self.view.endEditing(true)
        }
        
        // Filter array based on texted typed
        filteredMovies = movies.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        if(filteredMovies.count == 0) {
            isSearching = false
        } else {
            isSearching = true
        }
        self.collectionView.reloadData()
        
    }
    
}
