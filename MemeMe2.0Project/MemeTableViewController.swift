//
//  MemeTableViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/29/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit

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
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView?.image = meme.getMemedImage()
        return cell
    }

}
