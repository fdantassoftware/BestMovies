//
//  MainVC.swift
//  Best Movies
//
//  Created by Fabio Dantas on 27/09/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
import Reachability
import GSMessages
import CoreData

class MainVC: UIViewController {
    
    private var filteredMovies = [Movie]()
    private var isSearching = false
    private var movies = [Movie]()
    private let network = NetworkManager.sharedInstance
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var movieViewModel = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        movieViewModel.delegate = self
        // Here we handle connection issues at lunch
        
        NetworkManager.isUnreachable { networkManagerInstance in
            DispatchQueue.main.async {
                self.showMessage("The connection appears to be offline.", type: .error)
            }
        }
        
        NetworkManager.isReachable { networkManagerInstance in
            self.fetchMovies()
        }
        
        network.reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.showMessage("The connection appears to be offline.", type: .error)
            }
        }
        
        network.reachability.whenReachable = { reachability in
            self.fetchMovies()
        }
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshMoviesData(_:)), for: .valueChanged)
      
    }
    
    @objc private func refreshMoviesData(_ sender: Any) {
        // Fetch Movies
        fetchMovies()
    }
    
    func fetchMovies() {
        movieViewModel.fetchMovies(endPoint: .popular(page: 1, language: "en-US"))
    }
  
    override func viewDidAppear(_ animated: Bool) {
        // Here we handle connection issues at lunch
        
     
    }
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func saveData(data: Movie) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MoviesData", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(data.title, forKey: "title")
        newEntity.setValue(String(data.id), forKey: "id")
        newEntity.setValue(data.release_date, forKey: "date")
        newEntity.setValue(data.vote_average, forKey: "rate")
        newEntity.setValue(String(data.genre_ids[0]), forKey: "genre")
        newEntity.setValue(data.poster_path, forKey: "image")
        do {
            try context.save()
            print("saved")
        } catch let error {
            print("Error \(error)")
        }
    }
    
//    func getData() {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesData")
//
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "title") as! String)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    
  
 
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
        
        DispatchQueue.main.async {
            self.showMessage(error, type: .error)
        }
        
    }
    
    func didFailToParseData(error: String) {
        DispatchQueue.main.async {
            self.showMessage("An error has ocurred. Try again later.", type: .error)
        }
        
    }
    
    func checkMovie(id: Int) -> Bool {
        var value = false
        // Here we check if an movie already exists before saving
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesData")
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "id") as! String
                if title == String(id) {
                    value = true
                    break
                } else {
                    value = false
                }
            }
        } catch {
            print(error)
        }
        return value
    }
    
    func didGetData(data: ApiResults) {
        // Here we have our data ready
        DispatchQueue.main.async {
            self.movies = data.results
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            for ele in data.results {
                if !(self.checkMovie(id: ele.id)) {
                    self.saveData(data: ele)
                }
            }
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
        
        if searchBar.text == nil || searchBar.text == ""
        {
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
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

