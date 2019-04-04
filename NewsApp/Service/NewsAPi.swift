//
//  NewsAPi.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation


struct NewsAPI {
    
    static let base = "https://newsapi.org"
    
    static let headlines = "/v2/top-headlines?"
    static let everything = "/v2/everything?"
    
    static let countryParam = "country="
    static let categoryParam = "category="
    static let sourcesParam = "&sources="
    static let keywordParam = "q="
    
    ///for everything URL and for filtering purposes
    static let domainParam = "domains="
    static let sortByParam = "sortBy="
    
    static let key = "&apiKey=d6de66301f64417db1d972572d0d93ac"
    
    //create url for headlines
    static func getHeadlinesURL(country: String) -> String {
        return base + headlines + countryParam  + country + key
    }
    
    static func getEverythingURL(searchKeyword: String) -> String {
        return base + everything + keywordParam + searchKeyword + key
    }
    
    static func getFilterEverythingURL(searchKeyword: String, source: String) -> String {
        return base + everything + keywordParam + searchKeyword + sourcesParam + source + key
    }
    
}
