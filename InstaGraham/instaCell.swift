//
//  instaCell.swift
//  InstaGraham
//
//  Created by Cole McLemore on 3/5/16.
//  Copyright © 2016 Cole McLemore. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class instaCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var photoView: PFImageView!
    
    var instagramPost: PFObject! {
        
        didSet {
            self.photoView.file = instagramPost["picture"] as? PFFile
            self.photoView.loadInBackground()

            
        }
    }
}
