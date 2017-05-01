//
//  SignUpViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 5/1/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    let apiHelper = APIHelper()
    @IBAction func signUp(_ sender: AnyObject) {
        do {
            
            try apiHelper.registerUser(withUsersEmail: emailTextField.text!,
                                       withUsersPassword: passwordTextfield.text!,
                                       andConfirmPassword: confirmPasswordTextfield.text!,
                                       completionHandler: { (signInError) in
                                        guard signInError == nil else {
                                            self.handleError(withErrorCode: signInError!)
                                            return
                                        }
                                        //Successful Sign Up (No Errors)
                                        self.goToVehicles()
            })
            
            
        } catch SignInError.noEmail {
            Alerter.giveAlertIfUserDidNotProvideEmail(viewController: self)
        } catch SignInError.noPassword {
            Alerter.giveAlertIfUserDidNotProvidePassword(viewController: self)
        }catch SignInError.confirmPasswordNotEqualToPassword {
            Alerter.giveAlertForConfirmPasswordError(viewController: self)
        } catch {
            //Shouldn't reach here
        }
        
        
        
    }
    
}
extension SignUpViewController {
    func handleError(withErrorCode signInError:String) {
        // Operation Queue.main Puts Code On Main Thread So UI doesn't lag.
        OperationQueue.main.addOperation {
            Alerter.giveAlertForFault(faultCode: signInError, presentedBy: self)
        }
    }
    func goToVehicles() {
        self.performSegue(withIdentifier: Constants.loggedInIdentifier, sender: self)
        
    }

}
