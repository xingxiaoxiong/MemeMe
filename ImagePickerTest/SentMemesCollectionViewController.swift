//
//  SentMemesCollectionViewController.swift
//  ImagePickerTest
//
//  Created by shapeare on 6/18/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import UIKit

let reuseIdentifier = "SentMemeCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        var numberOfItemInARow = 4
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.itemSize = CGSize(width: self.view.frame.size.width / CGFloat(numberOfItemInARow), height: self.view.frame.size.width / CGFloat(numberOfItemInARow))
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        self.collectionView?.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SentMemesCollectionViewCell
    
        cell.memedImage?.image = memes[indexPath.row].memedImage!
    
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SentMemesCollectionToDetailMeme", sender: indexPath)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SentMemesCollectionToDetailMeme"{
            
            let path = sender as! NSIndexPath
            let controller = segue.destinationViewController as! MemeDetailViewController
            controller.meme = memes[path.row]
        }
    }

}
