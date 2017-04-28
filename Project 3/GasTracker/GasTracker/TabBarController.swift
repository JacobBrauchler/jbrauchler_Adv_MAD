//
//  TabBarController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/7/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.barTintColor = UIColor.init(colorLiteralRed: 145/255, green: 25/255, blue: 23/255, alpha: 1.0)
        self.tabBar.tintColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    }

}
