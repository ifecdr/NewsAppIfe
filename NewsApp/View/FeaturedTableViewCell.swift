//
//  FeaturedTableViewCell.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/1/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ViewModel()
 
    static let identifier = ["table", "table2"]

    func Configure(article : Article) {
        titleLabel.text = article.title
        descLabel.text = article.description
        
        if let imageUrl = article.urlToImage {
        
            viewModel.getimage(imageUrl) { image in
                if image == nil {
                    self.imageViewer.image = UIImage(named: "news1")
                } else {
                    self.imageViewer.image = UIImage(data: image!)
                }
            }
        } else {
            return
        }
    }
    
}
