//
//  SentMemesTabBarViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 8/5/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit
// TODO:
// WRITE SOME TESTS!!!!!!!
class SentMemesTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
        let navItem = UINavigationItem(title: "Sent Memes")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(done))
        let createNewMemeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: "selector")
        navItem.rightBarButtonItem = createNewMemeButton
        navigationBar.setItems([navItem], animated: false)
        self.view.addSubview(navigationBar)
    }
    
    @objc
    func done(){
        
    }
    
}
