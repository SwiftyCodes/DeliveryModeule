//
//  Extension+ViewController.swift
//  MVVM_MusicAPI
//
//  Created by Anurag Kashyap on 04/09/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: Simple Alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    //MARK: TextField - Single
    func alertWithSingleTextField(alertTitle title: String, alertMessage message : String, actionTitle actiontitle: String, textFieldPlaceholder placeholder:String, onCompletion: @escaping(String) -> Void) -> UIAlertController{
        var addedItem = UITextField()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actiontitle, style: .default) { (action) in
            onCompletion(addedItem.text!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in}
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = placeholder
            addedItem = alertTextField
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        return alert
    }
    
    //MARK:TextField - Double
    func alertWithDoubleTextField(alertTitle title: String, alertMessage message : String, actionTitle actiontitle: String, textFieldPlaceholder placeholder:String, onCompletion: @escaping(String,String) -> Void) -> UIAlertController{
        
        var nameTextField = UITextField()
        var lessonTextField = UITextField()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actiontitle, style: .default) { (action) in
            onCompletion(nameTextField.text!.lowercased(), lessonTextField.text!.lowercased())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in}
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = placeholder
            nameTextField = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Lesson type : Ski | Snowboard"
            lessonTextField = alertTextField
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        return alert
    }
}

