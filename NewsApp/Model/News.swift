//
//  News.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation

struct Result: Codable {
    let articles: [Article]
}

class Article: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String
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
}

struct Source: Codable {
    let id: String?
    let name: String
}
