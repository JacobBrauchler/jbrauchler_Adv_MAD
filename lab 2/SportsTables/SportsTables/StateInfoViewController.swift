//
//  StateInfoViewController.swift
//  SportsTables
//
//  Created by Jacob Brauchler on 2/21/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class StateInfoViewController: UITableViewController {

    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var sportNumber: UILabel!
    
    var name = String()
    var number = String()
    
    override func viewWillAppear(_ animated: Bool) {
        stateName.text=name
        sportNumber.text=number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
