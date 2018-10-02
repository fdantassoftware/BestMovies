//
//  DetailsVC.swift
//  Best Movies
//
//  Created by Fabio Dantas on 02/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    private var detailsViewModel = DetailsViewModel()
    var movie: Movie!
    private let network = NetworkManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.title
        detailsViewModel.delegate = self
        
        // Here we handle connection issues at lunch
        
        NetworkManager.isUnreachable { networkManagerInstance in
            DispatchQueue.main.async {
                self.showMessage("The connection appears to be offline.", type: .error)
            }
        }
        
        NetworkManager.isReachable { networkManagerInstance in
            self.fetchDetails()
        }
        
        network.reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.showMessage("The connection appears to be offline.", type: .error)
            }
        }
        
        network.reachability.whenReachable = { reachability in
            self.fetchDetails()
        }
      
    }
    
    func fetchDetails() {
        detailsViewModel.fetchMovieDetails(endPoint: .details(id: movie.id, language: "en-US"))
    }
 
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func linkPressed(_ sender: Any) {
        // Check if we have a valid link then open it on safari
        if linkBtn.titleLabel?.text != "-" {
            if let url = URL(string: linkBtn.titleLabel!.text!) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        
    }
    
    func hourFromseconds(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        return "\(hours)h\(minutes)m"
    }
    
  
    
   
    
}

extension DetailsVC: DetailsProtocol {
    
    // Here we update our UI
    func updateUI(movieDetails: MovieDetail) {
        languageLabel.text = movieDetails.original_language.capitalized
        revenueLabel.text = "$\(movieDetails.revenue)"
        
        if movieDetails.homepage != nil {
            linkBtn.setTitle(movieDetails.homepage!, for: .normal)
        } else {
           linkBtn.setTitle("Not Available", for: .normal)
        }
        
        if movieDetails.runtime != nil {
            runtimeLabel.text = hourFromseconds(seconds: movieDetails.runtime! * 60)
        } else {
            runtimeLabel.text = "Not Available"
        }
        
        if movieDetails.overview != nil {
            descriptionTextView.text = movieDetails.overview!
        }
        
        if movieDetails.backdrop_path != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(movieDetails.backdrop_path!)")
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "image-not-available")
        }
    }
    
    func didFailToParseData(error: String) {
        DispatchQueue.main.async {
            self.showMessage("An error has ocurred. Try again later.", type: .error)
        }
    }
    
    func requestDidFail(error: String) {
        DispatchQueue.main.async {
            self.showMessage(error, type: .error)
        }
    }
    
    func didGetData(data: MovieDetail) {
        // Data Available
        DispatchQueue.main.async {
            self.updateUI(movieDetails: data)
        }
        
    }
    
    
}
