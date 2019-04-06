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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func signOutTapped() {
        do {
            try Auth.auth().signOut()
            print("Signed Out")
            view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Could not sign out")
        }
        
        
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
            
            cell.imageViewer.image = UIImage(named: "news5")
            cell.imageViewer.layer.cornerRadius = cell.imageViewer.frame.size.width / 2
            cell.emailLabel.text = "ifecdr@yahoo.com"
        default:
            cell.settingLabel.text = ""
        }
        return cell
    }
    
    
}

