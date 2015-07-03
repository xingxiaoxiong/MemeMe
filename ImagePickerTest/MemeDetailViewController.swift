//
//  MemeDetailViewController.swift
//  ImagePickerTest
//
//  Created by shapeare on 6/18/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var meme:Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
    }

}
