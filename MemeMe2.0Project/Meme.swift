//
//  Meme.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/28/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    
    init(bottomText: String, topText: String, originalImage: UIImage, memedImage: UIImage) {
        self.bottomText = bottomText
        self.topText = topText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    private var bottomText: String?
    private var topText: String?
    private var originalImage: UIImage?
    private var memedImage: UIImage?
    
    public func getMemedImage() -> UIImage {
        return memedImage!
    }
    
    public func getOriginalImage() -> UIImage {
        return originalImage!
    }
    
    public func getTopText() -> String {
        return topText!
    }
    
    public func getBottomText() -> String {
        return bottomText!
    }
    
}
