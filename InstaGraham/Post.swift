//
//  Post.swift
//  InstaGraham
//
//  Created by Cole McLemore on 3/6/16.
//  Copyright © 2016 Cole McLemore. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class Post: NSObject {
    
    class func sendPost(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")

        post["picture"] = getPFFileFromImage(image)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        
        post.saveInBackgroundWithBlock { (Bool, error: NSError?) -> Void in
        }
        
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
