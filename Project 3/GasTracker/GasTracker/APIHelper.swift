//
//  APIHelper.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/24/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import FBSDKLoginKit
public enum SignInError: Error {
    case noEmail
    case noPassword
    case confirmPasswordNotEqualToPassword
    case fault(String)
}

class APIHelper: NSObject {
    
    let facebookLoginPermissions = ["user_friends", "email", "public_profile", "contact_email"]
    let  facebookFieldsMapping = [
        "id" : "facebookId",
        "name" : "name",
        "birthday": "birthday",
        "first_name": "firstName",
        "last_name" : "lastName",
        "gender": "gender",
        "picture":"picture",
        "email": "email"
    ]
    var backendless = Backendless.sharedInstance()
    
    func initializeBackendless() {
        backendless?.initApp(Constants.BACKENDLESS_APP_ID, secret:Constants.BACKENDLESS_SECRET_KEY, version:Constants.BACKENDLESS_VERSION_NUM)
    }
    func registerUser(withUsersEmail email:String, withUsersPassword password:String, andConfirmPassword confirmPassword:String, completionHandler:@escaping (String?) -> ()) throws {
        guard email != "" else {throw SignInError.noEmail}
        guard password != "" else {throw SignInError.noPassword}
        guard password == confirmPassword else {throw SignInError.confirmPasswordNotEqualToPassword}
        
        let user = BackendlessUser()
        user.email = email as NSString!
        user.password = password as NSString!
        
        backendless?.userService.registering(user,
                                             response: { (registeredUser) in
                                                self.backendless?.userService.login(email, password: password)
                                                self.backendless?.userService.setStayLoggedIn(true)
                                                completionHandler(nil)
        },
                                             error: { (fault) in
                                                completionHandler(fault?.faultCode)
        })
        
    }
    func signUserIn(withEmail email:String,withPassword password:String,completionHandler:@escaping (String?) -> ()) throws {
        guard email != "" else {throw SignInError.noEmail}
        guard password != "" else {throw SignInError.noPassword}
        
        backendless?.userService.login(email,
                                       password: password,
                                       response: { (user) in
                                        completionHandler(nil)
        },
                                       error: { (fault) in
                                        completionHandler(fault!.faultCode)
        })
        
        
        
    }
    func validUserTokenSync(_ completionHandler:@escaping ((Bool?)->Void)) {
        
        Types.tryblock({ () -> Void in
            
            let result = self.backendless?.userService.isValidUserToken() //as NSNumber
            completionHandler(true)
        },
                       
                       catchblock: { (exception) -> Void in
                        completionHandler(false)
                        print("Server reported an error (SYNC): \(exception as! Fault)")
        }
        )
    }
    func loginWithFacebook(token:FBSDKAccessToken,completionHandler:@escaping ((_ didGetUser:Bool)->())) {
        backendless?.userService.login(withFacebookSDK: token,
                                       permissions: self.facebookLoginPermissions,
                                       fieldsMapping: self.facebookFieldsMapping,
                                       response: { (curretUser) in
                                        self.backendless?.userService.setStayLoggedIn(true)
                                        completionHandler(true)
                                        
        },
                                       error: { (fault) in
                                        completionHandler(false)
        })
    }
}
