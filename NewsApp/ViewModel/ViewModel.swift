//
//  ViewModel.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/30/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func updateView()
}

class ViewModel {
    
    let countries = ["USA","Canada", "UK", "Ireland", "Australia", "Nigeria", "New Zealand", "South Africa", "Favorite"]
    let countryCode = ["us", "ca", "gb", "ie", "au", "ng", "nz", "sa", ""]
    
    //news source for filtering
    let source = ["Favorite", "cnn", "abc-news", "bbc-news" , "bloomberg" , "buzzfeed", "espn"]
    let sourceImg = ["redHeart","cnnImg", "abcImg", "bbcImg", "BloombergImg", "buzzImg", "espnImg"]
    //create variable and call delegate after the variable is initialized to update view
    var articleHeadlines = [Article]() {
        didSet {
            delegate?.updateView()
        }
    }
    var articleEverything = [Article]() {
        didSet {
            delegate?.updateView()
        }
    }
    
    var filteredArticle = [Article]() {
        didSet {
            delegate?.updateView()
        }
    }
    
    weak var delegate: ViewModelDelegate?
    
    func getHeadlines(_ countryCode: String) {
        ApiService.shared.getHeadlines(countryCode) { [unowned self] article  in
            self.articleHeadlines.removeAll()
            self.articleHeadlines = article
        }
    }
    
    func getSearchResult(_ keyword: String) {
        ApiService.shared.getEverything(keyword) { [unowned self] article in
            self.articleEverything.removeAll()
            self.articleEverything = article
        }
    }
    
    func getfilteredResult(_ keyword: String, _ param: String) {
        ApiService.shared.getFilteredEverything(keyword, param) { [unowned self] article in
            self.filteredArticle.removeAll()
            self.filteredArticle = article
        }
    }
    
    //Get image from the service with string
    func getimage(_ imageUrl: String, _ completion: @escaping (Data?)->() ) {
        
        let imageCompletion: (Data?) -> () =  { (d) in
            completion(d)
        }
        ImageDownloadService.shared.dowanloadImage(imageUrl, imageCompletion)
    }
    
    
}
