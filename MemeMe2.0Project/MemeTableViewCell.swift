//
//  MemeCollectionCell.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/28/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell
{
    static let ident = "MemeTableViewCell"
    
    lazy var memeTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello world"
        return label
    }()
    
    func setup(){
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(memeTextLabel)
        imageView?.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            (imageView?.topAnchor.constraint(equalTo: self.contentView.topAnchor))!,
            (imageView?.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor))!,
            (imageView?.widthAnchor.constraint(equalToConstant: self.contentView.frame.width / 2))!,
            (imageView?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor))!
            ])
        
        NSLayoutConstraint.activate([
            memeTextLabel.topAnchor.constraint(equalTo: (imageView?.topAnchor)!),
            memeTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            memeTextLabel.widthAnchor.constraint(equalToConstant: self.contentView.frame.width / 2),
            memeTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
}
