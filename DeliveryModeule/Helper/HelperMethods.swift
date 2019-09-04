//
//  Extensions.swift
//  ToDo_CoreData
//
//  Created by Anurag Kashyap on 30/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import UIKit

class HelperMethods {
    
    static var sharedInstance = HelperMethods()
    private init() {}
    
    //MARK: Alert TextField - Single
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
    
    //MARK: Alert TextField - Double
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
