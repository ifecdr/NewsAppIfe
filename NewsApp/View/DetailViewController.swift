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
    var image: UIImage!
    
    static let identifier = "featuredDetailSegue"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        self.imageViewer.image = image
        self.titleLabel.text = titleText
        self.descLabel.text = desc
        self.sourceLabel.text = source
        self.authorLabel.text = author
        self.publishedAtLabel.text = published
        self.contentLabel.text = content
    }
    

}
