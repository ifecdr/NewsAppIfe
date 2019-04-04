//
//  SearchTableViewCell.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 4/3/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit


class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    let viewModel = ViewModel()
    static let identifier = "searchCell"
    
    func configure (article: Article) {
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
