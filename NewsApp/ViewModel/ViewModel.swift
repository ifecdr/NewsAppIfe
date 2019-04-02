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
    
    weak var delegate: ViewModelDelegate?
    
    func getHeadlines() {
        ApiService.shared.getHeadlines() { [unowned self] article  in
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
    
    //Get image from the service with string
    func getimage(_ imageUrl: String, _ completion: @escaping (Data?)->() ) {
        
        let imageCompletion: (Data?) -> () =  { (d) in
            completion(d)
        }
        ImageDownloadService.shared.dowanloadImage(imageUrl, imageCompletion)
    }
    
}
