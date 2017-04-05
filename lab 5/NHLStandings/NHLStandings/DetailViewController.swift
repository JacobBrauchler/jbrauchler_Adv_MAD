//
//  DetailViewController.swift
//  NHLStandings
//
//  Created by Jacob Brauchler on 4/4/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var wins = ""
    var loses = ""
    var overtimeLoses = ""
    var points = ""
    var team = ""
    var detailDescriptionLabel = ""

    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var losesLabel: UILabel!
    @IBOutlet weak var overtimeLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        winsLabel.text = "\(wins) wins"
        losesLabel.text = "\(loses) losses"
        overtimeLabel.text = "\(overtimeLoses) Overtime Loses"
        pointsLabel.text = "\(points) points"
        navigationItem.title = team
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




