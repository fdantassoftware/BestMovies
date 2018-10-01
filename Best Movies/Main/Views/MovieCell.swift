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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = false
        return image
        
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Book", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let rate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Book", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let genre: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Book", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    func setupView() {
        addSubview(imageView)
        addSubview(title)
        addSubview(date)
        addSubview(rate)
        addSubview(genre)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2).isActive = true
        title.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        title.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        title.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0).isActive = true
        date.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0).isActive = true
        date.rightAnchor.constraint(equalTo: title.rightAnchor, constant: 0).isActive = true
        date.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        rate.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 0).isActive = true
        rate.leftAnchor.constraint(equalTo: date.leftAnchor, constant: 0).isActive = true
        rate.rightAnchor.constraint(equalTo: date.rightAnchor, constant: 0).isActive = true
        rate.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        genre.topAnchor.constraint(equalTo: rate.bottomAnchor, constant: 0).isActive = true
        genre.leftAnchor.constraint(equalTo: rate.leftAnchor, constant: 0).isActive = true
        genre.rightAnchor.constraint(equalTo: rate.rightAnchor, constant: 0).isActive = true
        genre.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
