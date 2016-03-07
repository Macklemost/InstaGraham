//
//  CameraViewController.swift
//  InstaGraham
//
//  Created by Cole McLemore on 3/6/16.
//  Copyright © 2016 Cole McLemore. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var CaptionField: UITextField!
    @IBOutlet weak var PictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion:  nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        PictureImageView.image = resize(originalImage, newSize: CGSize(width: 120, height: 120))
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func UploadOccur(sender: AnyObject) {
    
        Post.sendPost(PictureImageView.image, withCaption: CaptionField.text) { (Bool, error: NSError?) -> Void in
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Home Page")
            self.showViewController(vc as! UIViewController, sender: vc)
            
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
}
