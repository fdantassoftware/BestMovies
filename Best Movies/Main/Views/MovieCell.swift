//
//  MovieCell.swift
//  Best Movies
//
//  Created by Fabio Dantas on 01/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    func configureCell(movie: Movie) {
        imageView
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 4
        return image
        
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
        
    }()
    
    func setupView() {
        addSubview(imageView)
//        addSubview(title)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 3).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
