//
//  ViewController.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/28/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit
import AVKit
import NotificationCenter
import Photos
// TODO:
// WRITE SOME TESTS!!!!!!!
class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var meme: Meme!
    
    // UI Item outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    // Constraint for imageViewBottom
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    
    private var textFields = [UITextField]()
    
    /// not to be displayed by default, so set to false
    private var keyboardIsDisplayed = false
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 30)!,
        NSAttributedStringKey.strokeWidth.rawValue: -5
    ]
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getKeyboardSize(_ notification:Notification) -> CGRect {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue
    }
    
    @objc func keyboardWillChange(notification:NSNotification)
    {
        if let keyboardSize = getKeyboardSize(notification as Notification) as? CGRect {
            //convert gotten rect
            let r = self.view.convert(keyboardSize, from: nil)
            
            //test it
            if r.intersects(bottomTextField.frame) {
                print("intersects!!!")
                imageViewBottomConstraint.constant = -keyboardSize.height
            } else {
                imageViewBottomConstraint.constant = 0
            }
            self.view.updateConstraints()
        }
    }
    
    // SetupTextFields
    // If textField array is empty, populate it
    // Assign appropriate textFieldDelegate, default attributes, placeholder text, and alignment
    func setupTextFields() {
        if (textFields.count == 0){
            textFields.append(self.topTextField)
            textFields.append(self.bottomTextField)
        }
        
        for textfield in textFields {
            let delegate = MemeTextFieldDelegate()
            delegate.setDefaultText(newDefaultText: textfield.placeholder!)
            textfield.delegate = memeTextFieldDelegate
            textfield.defaultTextAttributes = memeTextAttributes
            textfield.text = textfield.placeholder
            textfield.textAlignment = .center
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
        if meme != nil {
            imageView.image = meme.getOriginalImage()
            topTextField.text = meme.getTopText()
            bottomTextField.text = meme.getBottomText()
            enableCancelShareButtons()
        } else if imageView.image != nil {
            enableCancelShareButtons()
        } else {
            shareButton.isEnabled = false
            cancelButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTextFields()
        checkForMediaPermissions()
       
    }
        
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func checkForMediaPermissions(){
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    private func pickImageFromAlbum(){
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
            case .authorized:
                self.showImagePicker(sourceType: .photoLibrary)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized {
                        self.showImagePicker(sourceType: .photoLibrary)
                    }
                })
            case .denied, .restricted:
                showAlert(title: "Unable to access photo library", message: "Please grant access to the photo library in your settings")
        }
    }
    
    private func pickImageFromCamera(){
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraStatus {
            case .authorized:
                self.showImagePicker(sourceType: .photoLibrary)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized {
                        self.showImagePicker(sourceType: .camera)
                    }
                })
            case .denied, .restricted:
                showAlert(title: "Unable to access photo library", message: "Please grant access to the photo library in your settings")
            }
        }
    
    func resetView(){
        imageView.image = nil
        topTextField.text = topTextField.placeholder
        bottomTextField.text = bottomTextField.placeholder
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    func generateMemedImage() -> UIImage {
        self.toolBar.isHidden = true
        self.navBar.isHidden = true
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        imageView.updateConstraints()
        
        UIGraphicsBeginImageContext(self.view.safeAreaLayoutGuide.layoutFrame.size)
        view.drawHierarchy(in: self.view.safeAreaLayoutGuide.layoutFrame, afterScreenUpdates: true)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.toolBar.isHidden = false
        self.navBar.isHidden = false
        imageView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor)
        imageView.bottomAnchor.constraint(equalTo: self.toolBar.bottomAnchor)
        imageView.updateConstraints()
        
        return memedImage
    }
    
    @IBAction func share(_ sender: Any) {
        if let originalImage = imageView.image {
            let memedImage = generateMemedImage()
            
            let imageToShare = [ memedImage ]
            
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook ]
            
            present(activityViewController, animated: true, completion: nil)
            
            activityViewController.completionWithItemsHandler = { activity, success, items, error in
                if success {
                    let meme = Meme(bottomText: self.bottomTextField.text!, topText: self.topTextField.text!, originalImage: originalImage, memedImage: memedImage)
                    self.appDelegate.memes.append(meme)
                    self.resetView()
                    self.dismiss(sender)
                }
            }
        }
    }
    
    public func enableCancelShareButtons(){
        shareButton.isEnabled = true
        cancelButton.isEnabled = true
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        pickImageFromAlbum()
    }

    @IBAction func openCamera(_ sender: Any) {
        pickImageFromCamera()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            enableCancelShareButtons()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any){
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
}


