//
//  ProfileViewController.swift
//  InstaGraham
//
//  Created by Cole McLemore on 3/6/16.
//  Copyright © 2016 Cole McLemore. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
    }
}
