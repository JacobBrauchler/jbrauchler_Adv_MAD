//
//  SecondViewController.swift
//  sports
//
//  Created by Jacob Brauchler on 1/31/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBAction func goToEspn(_ sender: Any) {
        if(UIApplication.shared.canOpenURL(URL(string: "sportscenter://")!)){
            //open the app with this URL scheme
            UIApplication.shared.open(URL(string: "sportscenter://")!, options: [:], completionHandler: nil)
        }else {
            if(UIApplication.shared.canOpenURL(URL(string: "http://www.espn.com")!)){
                UIApplication.shared.open(URL(string: "http://www.espn.com")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string: "http://www.apple.com/music/")!, options: [:], completionHandler: nil)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

