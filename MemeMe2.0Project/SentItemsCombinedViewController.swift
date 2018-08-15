//
//  SentItemsCombinedViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 8/5/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit
// TODO:
// WRITE SOME TESTS!!!!!!!
class SentItemsCombinedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    //var collectionView: UICollectionView!
    var collectionCell: UICollectionViewCell!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var memes = [Meme]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let collectionViewReuseIdentifier = "memeCollectionViewCell"
    let tableViewReuseIdentifier = "memeTableViewCell"
    let collectionIdentifier = "StandAloneCollection"
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (screenSize.width / 3), height: (screenSize.width / 3))
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    public func updateData() {
        memes = appDelegate.memes
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configureCollectionView()
        configureTableView()
        collectionView.backgroundColor = UIColor.white
        memes = appDelegate.memes
    }
    
    func configureTableView(){
        tableView.register(MemeTableViewCell.self, forCellReuseIdentifier: "MemeTableViewCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.toolbar.topAnchor)
            ])
    }

    func configureCollectionView(){
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: "MemeCollectionViewCell")
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.toolbar.topAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.setup()
        cell.imageView.image = meme.getMemedImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.setup()
        cell.imageView?.image = meme.getMemedImage()
        
        let frontText = String(meme.getTopText().prefix(8))
        let backText = String(meme.getBottomText().suffix(8))
        
        let fullText = "\(frontText)...\(backText)"
        
        cell.memeTextLabel.text = fullText
        return cell
    }
    
    func openEditViewController(meme: Meme) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.loadViewIfNeeded()
        detailController.memeImageView.image = meme.getMemedImage()
        self.show(detailController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openEditViewController(meme: memes[(indexPath as NSIndexPath).row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openEditViewController(meme: memes[(indexPath as NSIndexPath).row])
    }
    
    @IBAction func tableViewButtonPress(_ sender: Any) {
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    @IBAction func collectionViewButtonPress(_ sender: Any) {
        tableView.isHidden = true
        collectionView.isHidden = false
    }
}
