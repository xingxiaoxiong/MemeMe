//
//  SentMemesTableViewController.swift
//  ImagePickerTest
//
//  Created by shapeare on 6/18/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        cell.imageView?.image = memes[indexPath.row].memedImage
        
        if let textLabel = cell.textLabel {
            textLabel.text = memes[indexPath.row].topText! + " " + memes[indexPath.row].bottomText!
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("SentMemeToMemeDetail", sender: self)
        var controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SentMemeToMemeDetail"{
            
            let path = self.tableView.indexPathForSelectedRow()!
            let controller = segue.destinationViewController as! MemeDetailViewController
            controller.meme = memes[path.row]
        }
    }
    
}
