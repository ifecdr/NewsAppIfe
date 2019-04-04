//
//  APIServices.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation

//use typeaalias

final class ApiService {
    static let shared = ApiService()
    
    // create session allowing caching of data
    private let session: URLSession
    private init() {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession.init(configuration: config)
    }
    
    
    //funtiions gets the headlines in the USA
    func getHeadlines(_ countryCode: String,
                      completion: @escaping ([Article]) -> ()) {
        let country = countryCode
        if let url = URL(string: NewsAPI.getHeadlinesURL(country: country)) {
            //array of article
            var articleArray = [Article]()
            
            session.dataTask(with: url) { (d, _, e) in
                //check for errors
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(Result.self, from: data)
                        
                        //iterate through the response and add each article to the article array
                        for article in responseData.articles {
                            articleArray.append(article)
                        }
                        completion(articleArray)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }.resume()
        }
    }
    
    //funtions get everything from a search keyword
    func getEverything(_ keyword: String, completion: @escaping ([Article]) -> ()) {
        //get the url
        if let url = URL(string: NewsAPI.getEverythingURL(searchKeyword: keyword)) {
            //array of article
            var articleArray = [Article]()
            
            session.dataTask(with: url) { (d, _, e) in
                //check for errors
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(Result.self, from: data)
                        
                        //iterate through the response and add each article to the article array
                        for article in responseData.articles {
                            articleArray.append(article)
                        }
                        completion(articleArray)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }.resume()
        }
    }
    
    
    
    //funtion for filter searches
    func getFilteredEverything(_ keyword: String, _ param: String, completion: @escaping ([Article]) -> ()) {
        //get the url
        if let url = URL(string: NewsAPI.getFilterEverythingURL(searchKeyword: keyword, source: param)) {
            //array of article
            var articleArray = [Article]()
            
            session.dataTask(with: url) { (d, _, e) in
                //check for errors
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(Result.self, from: data)
                        
                        //iterate through the response and add each article to the article array
                        for article in responseData.articles {
                            articleArray.append(article)
                        }
                        completion(articleArray)
                    } catch {
                        print("Error: \(error)")
                    }
                }
                }.resume()
        }
    }
}
