//
//  UIAlertController+Extension.swift
//  Freddy
//
//  Created by Sonam Dhingra on 6/28/16.
//  Copyright © 2016 Sonam Dhingra. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
        
    class func defaultSingleActionAlertStyleWithMessage(title: String?, message: String?, buttonTitle: String, buttonCompletion: CompletionClosure?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .Default, handler: { (action) in
            buttonCompletion?()
        }))
        return alertController
    }
}