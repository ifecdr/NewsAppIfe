//
//  SearchFilteredCollectionViewCell.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/4/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class SearchFilteredCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sourceImage: UIImageView!
    
    static let identifier = "filterCell"
    
    func configure (image: String) {
        self.sourceImage.image = UIImage(named: image)
    }
    
}
