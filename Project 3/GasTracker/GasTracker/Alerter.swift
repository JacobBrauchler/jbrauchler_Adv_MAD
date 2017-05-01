//
//  Alerter.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/24/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class Alerter: NSObject {
    class func giveAlertForConfirmPasswordError(viewController:UIViewController) {
        let alertController = UIAlertController(title: "Error!",
                                                message: "You Have Entered Two Different Passwords!",
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    class func giveAlertIfUserDidNotProvideEmail(viewController:UIViewController) {
        let alertController = UIAlertController(title: "Error!",
                                                message: "No Email",
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    class func giveAlertIfUserDidNotProvidePassword(viewController:UIViewController) {
        let alertController = UIAlertController(title: "Error!",
                                                message: "No Password",
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    class func giveAlertForFault(faultCode:String, presentedBy viewController:UIViewController) {
        var errorMessage = ""
        switch faultCode {
        case "3040": errorMessage = "Email is in wrong format"
        case "3003":  errorMessage = "Invalid Email Or Password"
        default:   errorMessage = "Error Signing In. Please Try again. Check your connection."
            
        }
        
        let alertController = UIAlertController(title: "Error!",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style:
            .default, handler: nil)
        
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
}
