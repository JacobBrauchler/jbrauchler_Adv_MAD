//
//  SignInViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/24/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

class SignInViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let apiHelper = APIHelper()
    //var cellarService:CellarService!
    //MARK: Actions
    @IBAction func hitSignIn(_ sender: AnyObject) {
        do {
            try apiHelper.signUserIn(withEmail: emailTextfield.text!,
                                     withPassword: passwordField.text!,
                                     completionHandler: {[weak self] (signInError) in
                                        DispatchQueue.main.async {
                                            if let errorCode = signInError {
                                                self?.handleError(withErrorCode: errorCode)
                                            } else {
                                                self?.goToVehicles()
                                            }
                                        }
                                        
            })
        } catch SignInError.noEmail {
            Alerter.giveAlertIfUserDidNotProvideEmail(viewController: self)
        } catch SignInError.noPassword {
            Alerter.giveAlertIfUserDidNotProvidePassword(viewController: self)
        } catch {
            print("error is \(error)")
        }
    }
    
    
    
    @IBAction func hitSignUp(_ sender: AnyObject) {
        do {
            
            try apiHelper.registerUser(withUsersEmail: emailTextfield.text!,
                                       withUsersPassword: passwordField.text!,
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
        }  catch {
            //shouldn't reach here
        }
        
        
    }
    

    @IBAction func userPressedSignOut(withSegue segue:UIStoryboardSegue) {
        
    }
}
extension SignInViewController {
    func handleError(withErrorCode signInError:String) {
        Alerter.giveAlertForFault(faultCode: signInError, presentedBy: self)
    }
    func goToVehicles() {
        self.performSegue(withIdentifier: Constants.signUpSegueIdentifier,
                          sender: self)
    }
}
