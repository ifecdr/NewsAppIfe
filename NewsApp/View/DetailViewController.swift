//
//  DetailViewController.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/5/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var titleText: String!
    var desc: String!
    var source: String!
    var author: String!
    var published: String!
    var content: String!
    var image: String!
    
    let viewModel = ViewModel()
    
    static let identifier = "DetailViewController"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        
        if let imageUrl = image {
            
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
        
        self.titleLabel.text = titleText
        self.descLabel.text = desc
        self.sourceLabel.text = source
        self.authorLabel.text = author
        self.publishedAtLabel.text = published
        self.contentLabel.text = content
    }
    

}
