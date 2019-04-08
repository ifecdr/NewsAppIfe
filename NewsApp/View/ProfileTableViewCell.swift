//
//  ProfileTableViewCell.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 4/5/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var favCounter: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var favImg: UIImageView!
    
    static let identifier = [ "profileButtonCell", "profileCell", "profileSettingsCell" ]
}
