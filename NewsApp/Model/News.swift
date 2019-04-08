//
//  News.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Result: Codable {
    let articles: [Article]
}

struct Source: Codable {
    let id: String?
    let name: String
}

class Article: Codable {
    let source: Source
    let author: String?
    let title, description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    
    init(source: Source, author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String : Any] else {
            return nil
        }
        self.source = Source(id: value[Constants.id] as? String, name: value[Constants.name] as! String)
        self.author = value[Constants.author] as? String
        self.title = value[Constants.title] as? String
        self.description = value[Constants.description] as? String
        self.url = value[Constants.url] as! String
        self.urlToImage = value[Constants.urlToImage] as? String
        self.content = value[Constants.content] as? String
        self.publishedAt = value[Constants.publishedAt] as! String
    }
    
}

