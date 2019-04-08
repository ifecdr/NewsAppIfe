//
//  FireViewModel.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 4/6/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation

class FireViewModel {
    static let shared = FireViewModel()
    
    var article = [Article]()
    
    
    
    func getFirebase() {
        
        FireService.shared.get { [unowned self] article in
            self.article = article
            
            //notifications or delegate to update with current value from firebase
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("updateFire"), object: nil)
            }
            
            print("Recieved from Firebase")
        }
    }
}
