//
//  MemeCollectionViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/28/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes = [Meme]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memes = appDelegate.memes
    }
    
    func openCreateMemeView() {
        self.dismiss(animated: true, completion: nil)
    }
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView?.image = meme.getMemedImage()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeViewController") as! CreateMemeViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.tabBarController!.show(detailController, sender: nil)
    }
}
