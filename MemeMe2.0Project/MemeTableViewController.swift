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
        return memes.count
    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView?.image = meme.getMemedImage()
        
        let frontText = String(meme.getTopText().prefix(8))
        let backText = String(meme.getBottomText().suffix(8))
        
        let fullText = "\(frontText)...\(backText)"
        
        cell.memeTextView.text = fullText
        return cell
    }

}
