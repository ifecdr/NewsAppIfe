//
//  FirebaseService.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 4/6/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation
import Firebase

class FireService {
    
    static let shared = FireService()
    private init() {}
    
    let ref = Database.database().reference(withPath: UserDefaults.standard.value(forKey: Constants.username) as! String)
    
    //CRUD Operation to firebase
    
    func save() {
        
    }
    
}
