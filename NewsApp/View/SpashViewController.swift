//
//  ViewController.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class SpashViewController: UIViewController {

    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get a reference to the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if UserDefaults.standard.bool(forKey: Constants.isLoginedIn) {
            
        } else {
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            appDelegate.window?.rootViewController = loginVC
        }
    }


}

