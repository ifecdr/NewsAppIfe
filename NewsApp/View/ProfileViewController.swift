//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/1/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favCount: UILabel!
    
    var fireViewModel = FireViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firebaseObserver()
        fireViewModel.getFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fireViewModel.getFirebase()
    }
    
    @objc func firebaseUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func firebaseObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(firebaseUpdate), name: Notification.Name("updateFire"), object: nil)
    }
    
    @objc func signOutTapped() {
        let alert = UIAlertController(title: "Sign Out!", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [unowned self] action in
            do {
                try Auth.auth().signOut()
                print("Signed Out")
                if UserDefaults.standard.bool(forKey: Constants.didSignIn) == true {
                    UserDefaults.standard.set(false, forKey: Constants.isLoginedIn)
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                } else {
                    UserDefaults.standard.set(false, forKey: Constants.isLoginedIn)
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    self.view.window?.rootViewController? =  storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
                
            } catch {
                print("Could not sign out")
            }
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
        
        
        
    }

}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 47
        case 1:
            return 203
        default:
            return 60
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier[indexPath.section], for: indexPath) as! ProfileTableViewCell
        switch indexPath.section {
        case 0:
            cell.signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        case 1:
            let butImage = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
            cell.favImg.image = butImage
            cell.favImg.tintColor = .red
            cell.favCounter.text = String(fireViewModel.article.count)
            cell.imageViewer.image = UIImage(named: "news5")
            cell.imageViewer.layer.cornerRadius = cell.imageViewer.frame.size.width / 2
            cell.emailLabel.text = UserDefaults.standard.value(forKey: Constants.username) as? String
        default:
            cell.settingLabel.text = ""
        }
        return cell
    }
    
    
}

