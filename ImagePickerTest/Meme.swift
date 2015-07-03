//
//  Meme.swift
//  ImagePickerTest
//
//  Created by shapeare on 6/17/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText:String?
    var bottomText:String?
    var image:UIImage?
    var memedImage:UIImage?
    
    init(topText: String?, bottomText: String?, image: UIImage?, memedImage: UIImage?) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}