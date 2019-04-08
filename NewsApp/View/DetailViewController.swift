//
//  DetailViewController.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/5/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit
import FirebaseAuth

class DetailViewController: UIViewController {

    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var favoriteBut: UIButton!
    
    var id: String?
    var titleText: String!
    var desc: String!
    var source: String!
    var author: String?
    var published: String!
    var content: String?
    var url: String?
    var image: String!
    var isFavorite: Bool = false
    //var butImage: UIImage!
    
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
        
        let butImage = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        favoriteBut.setImage(butImage, for: .normal)
        favoriteBut.tintColor = .gray
        
        if isFavorite {
            self.favoriteBut.tintColor = .red
        } else {
            
        }
        
        
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        let article = Article(source: Source(id: self.id, name: self.source),
                             author: self.author ?? "",
                             title: self.titleText,
                             description: self.desc,
                             url: self.url ?? "",
                             urlToImage: self.image,
                             publishedAt: self.published,
                             content: self.content ?? "")
        
        
        if !isFavorite {
            FireService.shared.save(article)
            self.favoriteBut.tintColor = .red
        } else {
            self.favoriteBut.tintColor = .gray
            FireService.shared.remove(article)
        }
    }
    
}
