//
//  FirebaseService.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 4/6/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

final class FireService {
    
    static let shared = FireService()
    private init() {}
    
    let userRef = Database.database().reference(withPath: UserDefaults.standard.value(forKey: Constants.username) as! String)
    lazy var ref = userRef.child(Constants.article)
    
    let fireViewModel = FireViewModel()
    //CRUD Operation to firebase
    
    func save(_ article: Article) {
        
        let uuid = UUID().uuidString
        ref.child(article.source.id ?? uuid).child(Constants.id).setValue(article.source.id ?? uuid)
        ref.child(article.source.id ?? uuid ).child(Constants.title).setValue(article.title)
        ref.child(article.source.id ?? uuid).child(Constants.description).setValue(article.description)
        ref.child(article.source.id ?? uuid).child(Constants.author).setValue(article.author)
        ref.child(article.source.id ?? uuid).child(Constants.url).setValue(article.url)
        ref.child(article.source.id ?? uuid).child(Constants.urlToImage).setValue(article.urlToImage)
        ref.child(article.source.id ?? uuid).child(Constants.publishedAt).setValue(article.publishedAt)
        ref.child(article.source.id ?? uuid).child(Constants.name).setValue(article.source.name)
        ref.child(article.source.id ?? uuid).child(Constants.content).setValue(article.content)
        
        
        print("Article Saved to Firebase")
    }
    
    
    func remove(_ article: Article) {
        ref.child(article.source.id!).removeValue()
        //fireViewModel.getFirebase()
    }
    
    func get(firebase completion: @escaping ([Article]) -> ()) {
        var articleArr = [Article]()
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
//            var keyArr: [Any] = []
//            let value = snapshot.value as? NSDictionary
//            for (key) in value!{
//                keyArr.append(key )
//            }
            for snap in snapshot.children {
                let data: DataSnapshot = snap as! DataSnapshot
                
                let article = Article(snapshot: data)
                articleArr.append(article!)
            }
            completion(articleArr)
        }
    }
    
    
    func create(user: String) {
        Database.database().reference(withPath: user).setValue(user)
    }
}
