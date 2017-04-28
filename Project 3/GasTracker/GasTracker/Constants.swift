//
//  Constants.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/24/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation
struct Constants {
    
    
    //MARK - WineFeedInfo Fetch All Endpoint
    static let kWineFeedInfoEndpoint = "http://api.backendless.com/v1/data/WineForFeed"
    
    static func getEndPoint(withWhereCluase whereClause:String)->String {
        guard whereClause != "" else {
            return kWineFeedInfoEndpoint
        }
        return kWineFeedInfoEndpoint + "?where= \(whereClause)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    //MARK: MainStoryboard
    static let mainStoryboard = "Main"
    
    //MARK: CoreDataModelNames
    
    
    
    //MARK: Backendless Stuff
    static let BACKENDLESS_APP_ID = "C50A26B8-3228-C6D5-FF49-1062617C6900"
    static let BACKENDLESS_SECRET_KEY = "A09650F7-6844-17C7-FF01-0AB0BC2D6A00"
    static let BACKENDLESS_VERSION_NUM = "v1"
    
    
    
    //MARK: TableView Identifiers
    static let feedCellID = "feedCell"
    static let cellarCell = "cellarCell"
    
    
    //MARK: ViewController Identifiers
    static let signInViewControllerID = "SignIn"
    static let mainTabBarControllerID = "MainTabBarController"
    static let signInNavigationControllerID = "SignInNavigationController"
    
    
    //MARK: Segue Identifiers
    static let signInSegueIdentifier = "goToApp"
    static let signUpSegueIdentifier = "goToApp"
    static let addWineManuallySegueIdentifier = "AddWine"
    static let wineDetailSegue = "goToWineBottleDetailViewController"
    static let learnDetailSegue = "goToLearnDetailViewController"
    
    
    //MARK: UnwindSegue Identifiers
    static let unwindSegueToCellar = "segueWithUnwindSegue"

}
