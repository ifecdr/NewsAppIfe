//
//  ViewController.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/29/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit
import FirebaseAuth

class SpashViewController: UIViewController {

    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get a reference to the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let storyboardSecond = UIStoryboard(name: "Second", bundle: Bundle.main)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if  Auth.auth().currentUser != nil && UserDefaults.standard.value(forKey: Constants.isLoginedIn) != nil {
            UserDefaults.standard.set(false, forKey: Constants.didSignIn)
            let mainVC = storyboardSecond.instantiateViewController(withIdentifier: "SecondStoryboardTab") as! UITabBarController
            appDelegate.window?.rootViewController = mainVC
        } else {
            UserDefaults.standard.set(true, forKey: Constants.didSignIn)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            appDelegate.window?.rootViewController = loginVC
        }
    }


}

