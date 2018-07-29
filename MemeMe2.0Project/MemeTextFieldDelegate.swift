//
//  MemeTextFieldDelegate.swift
//  MemeMe2.0Project
//
//  Created by Sean Conrad on 7/28/18.
//  Copyright © 2018 Sean Conrad. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {

    private var defaultText = ""
    
    public func setDefaultText(newDefaultText: String){
        defaultText = newDefaultText
    }
    
    public func getDefaultText() -> String {
        return defaultText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        let currentText = textField.text
        
        // If the current text is the default value, clear it so the user may enter a new value
        if currentText == defaultText {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // if text field is blank, assign to be the default value
        if let currentText = textField.text {
            if currentText == "" {
                textField.text = defaultText
            }
        }
        // dismiss the kyeboard
        textField.resignFirstResponder()
    }
    
}
