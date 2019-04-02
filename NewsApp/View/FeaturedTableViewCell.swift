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
    
    let viewModel = ViewModel()
 
    static let identifier = "table"

    func Configure(article : Article) {
        titleLabel.text = article.title
        descLabel.text = article.description
        
//        guard let imageUrl = article.urlToImage else {
//            return
//        }
        viewModel.getimage(article.urlToImage) { image in
            self.imageViewer.image = UIImage(data: image!)
        }
    }
    
}
