//
//  ImageDownloadService.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation


final class ImageDownloadService {
    
    static let shared = ImageDownloadService()
    
    private var enqueued = Set<String>()
    private let cache = NSCache<NSString, NSData>()
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func dowanloadImage(_ urlString: String, _ completion: @escaping (Data?) -> (), _ queue: DispatchQueue = DispatchQueue.main) {
        let nsStr = NSString(string: urlString)
        
        //check if the image exists in cache then pass it into completion and return
        if let nsDat = cache.object(forKey: nsStr) {
            completion(Data(referencing: nsDat))
            return
        }
        
        if enqueued.contains(urlString) {
            completion(nil)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        enqueued.insert(urlString)
        session.dataTask(with: url) { (d, _, e) in
            if let error = e {
                print("Error: \(error)")
            }
            
            guard let dat = d else {
                completion(nil)
                return
            }
            
            self.cache.setObject(NSData(data: dat), forKey: nsStr)
            self.enqueued.remove(urlString)
            queue.async {
                completion(dat)
            }
            
        }.resume()
    }
}
