//
//  MemeDetailViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 8/15/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    

    var backButton: UIButton!
    
    @IBAction func returnToSent(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet var memeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
