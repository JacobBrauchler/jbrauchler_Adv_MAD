//
//  Alerter.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/24/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class Alerter: NSObject {
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
    
    /**
     This sets an alert if the user did not enter a name for their Wine OR take a picture of thier Wine.
     
     ## Important Notes ##
     1. WineCreationError.NoName = user did not enter a name
     2. WineCreationError.NoImage = user did not enter an image
     */
    //class func showAlertForErrorWhileAddingWineToCellar(withError error:WineCreationError, presentOnTopOfViewController viewController:UIViewController) {
        //var errorMessage:String!
        //switch error {
        //case .NoName: errorMessage = "You did not enter a Wine Name!"
        //
        //case .NoImage: errorMessage = "You did not enter a photo for your wine!"
            //
            
        //default: break
            //
        //}
        //let alertController = UIAlertController(title: "Error!",
                                                //message: errorMessage,
                                                //preferredStyle: .alert)
    
        //let alertAction = UIAlertAction(title: "OK", style:
            //.default, handler: nil)
        
        //alertController.addAction(alertAction)
        //viewController.present(alertController, animated: true, completion: nil)
        
    //}
}

