//
//  AppDelegate.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 1/21/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift
import FBSDKCoreKit
import FBSDKLoginKit

var realm = try! Realm()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let apiHelper = APIHelper()
    var window: UIWindow?
    var backendless = Backendless.sharedInstance()
    var currentUser:BackendlessUser? {
        get {
            return backendless?.userService.currentUser
        }
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 145/255, green: 25/255, blue: 23/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        //UIApplication.shared.statusBarStyle = .lightContent
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.init(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
        
        if currentUser == nil {
            goToSignIn()
        }

        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }
    
    // MARK: Facebook Login
    //When Facebook Login Button Is Hit, this method is called.
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        let result = FBSDKApplicationDelegate.sharedInstance().application(app,
                                                                           open: url,
                                                                           sourceApplication: sourceApplication,
                                                                           annotation: annotation)
        if result == true {
            let token = FBSDKAccessToken.current()
            guard token != nil else {
                return false //Do not login with facebook. Invalid token
            }
            apiHelper.loginWithFacebook(token: token!,
                                        completionHandler: { (currentUser) in
                                            guard currentUser != false else {
                                                return
                                            }
                                            self.apiHelper.validUserTokenSync({ (isValidToken) in
                                                guard isValidToken == true else {
                                                    return
                                                }
                                                self.goToVehicles()
                                            })
            })
        }
        return result
    }
    

}

extension AppDelegate {
    
    func goToSignIn() {
        OperationQueue.main.addOperation {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBoard = UIStoryboard(name: Constants.mainStoryboard,
                                          bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.signInNavigationControllerID) as! SignInNavigationController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
    }
    func goToVehicles() {
        OperationQueue.main.addOperation {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBoard = UIStoryboard(name: Constants.mainStoryboard,
                                          bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.mainTabBarControllerID) as! MainTabBarController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
    }
}
