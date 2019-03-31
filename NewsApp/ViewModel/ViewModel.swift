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
    var articleHeadlines = [Article]()
    var articleEverything = [Article]()
    
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
    
}
