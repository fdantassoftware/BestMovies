//
//  MovieCell.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageViewX!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    override func awakeFromNib() {
        styleCell()
    }
    
    
    
    func styleCell() {
        // Style CollectionView Cell
        self.layer.cornerRadius = 4.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius:
            self.contentView.layer.cornerRadius).cgPath
    }
    
    
    func configureCell(movie: Movie) {
        if movie.poster_path != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.poster_path!)")
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "image-not-available")
        }
        title.text = movie.title
        let dateFromString = movie.release_date.toDate(dateFormat: "yyyy-mm-dd")
        date.text = "Release: \(dateFromString.toString(dateFormat: "MMM dd, yyyy"))"
        rate.text = "Rating: \(movie.vote_average)"
        if !(GenreHelper.shared.genres.isEmpty) {
            // Here we get our first genre and grab the name from our helper array
            if let ele = GenreHelper.shared.genres.first(where: {$0.id == movie.genre_ids[0]}) {
                genre.text = "Genre: \(ele.name)"
            }
        }
    }
    
}
