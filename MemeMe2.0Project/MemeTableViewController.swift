//
//  MemeTableViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/29/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit
// TODO:
// WRITE SOME TESTS!!!!!!!
class MemeTableViewController: UITableViewController {
    
    var memes = [Meme]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        memes = appDelegate.memes
    }

    func openCreateMemeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
        

}
