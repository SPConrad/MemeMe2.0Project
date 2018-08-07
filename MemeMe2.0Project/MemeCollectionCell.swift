//
//  MemeCollectionCell.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/28/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit
// TODO:
// WRITE SOME TESTS!!!!!!!
class MemeCollectionViewCell: UICollectionViewCell
{
    static let ident = "MemeCollectionViewCell"
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
