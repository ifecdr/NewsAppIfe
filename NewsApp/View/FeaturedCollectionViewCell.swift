//
//  FeaturedCollectionViewCell.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/1/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionButton: UIButton!
    
    static let identifier = "featuredCollection"
    
    func configure(countryLabel: String) {
        self.collectionButton.setTitle(countryLabel, for: .normal)
        //self.collectionButton.frame.size.width = CGFloat(integerLiteral: countryLabel.count * 3)
    }
    
    
}
