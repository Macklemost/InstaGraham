//
//  HomePageViewController.swift
//  InstaGraham
//
//  Created by Cole McLemore on 3/5/16.
//  Copyright © 2016 Cole McLemore. All rights reserved.
//

import UIKit
import Parse

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        fetchData()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        fetchData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("instaCell", forIndexPath: indexPath) as! instaCell
        let postsArray = posts![indexPath.row]
        cell.authorLabel.text = postsArray["author"] as? String
        cell.commentLabel.text = postsArray["caption"] as? String
        cell.photoView.file = postsArray["picture"] as? PFFile
        cell.photoView.loadInBackground()

        return cell
    }
    func fetchData() {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts?.count)
        if posts != nil {
        return (posts?.count)!
        } else {
            return 0
        }
        }

}
