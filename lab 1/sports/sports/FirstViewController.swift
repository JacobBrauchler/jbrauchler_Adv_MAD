//
//  FirstViewController.swift
//  sports
//
//  Created by Jacob Brauchler on 1/31/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var sportPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var LogoView: UIImageView!
    
    let sportComponent = 0
    let teamComponent = 1
    
    var sportTeams = [String: [String]]()
    var sports = [String]()
    var teams = [String]()
    var sportrow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let path = getDataFile() else{
            print("Error loading file")
            return
        }
        // use NSDictionary to load the plist and cast to a Dictionary
        sportTeams =  NSDictionary(contentsOfFile: path) as! [String:[String]]
        // asign all the Dictionary keys in the sports array
        sports = Array(sportTeams.keys)
        // assign all the teams for the first sport in the teams array
        teams = sportTeams[sports[0]]! as [String]
    }
    
    
    func getDataFile() -> String? {
        //use a Bundle object of the directory for our application to retrieve the pathname of sportTeams.plist
        guard let pathString = Bundle.main.path(forResource: "sportTeams", ofType: "plist") else {
            return nil
        }
        return pathString
    }
    
    //Methods to implement the picker
    //Required for the UIPickerViewDataSource protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == sportComponent {
            return sports.count
        } else {
            return teams.count
        }
    }
    
    //Picker Delegate methods
    //returns the title for the row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == sportComponent {
            return sports[row]
        } else {
            return teams[row]
        }
        
    }
    
    //Called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //checks which component was picked
        if component == sportComponent {
            let selectedsport = sports[row] //gets the selected sport
            teams = sportTeams[selectedsport]! //gets the teams for the selected sport
            sportPicker.reloadComponent(teamComponent) //reload the team component
            sportPicker.selectRow(0, inComponent: teamComponent, animated: true) //set the team component back to 0
        }
        sportrow = pickerView.selectedRow(inComponent: sportComponent) //gets the selected row for the sport
        let teamrow = pickerView.selectedRow(inComponent: teamComponent) //gets the selected row for the team
        choiceLabel.text = "You like the \(teams[teamrow]) in the \(sports[sportrow])"
        if sportrow == 0 {
            LogoView.image = UIImage(named: "MLS")!
        }
        if sportrow == 1 {
            LogoView.image = UIImage(named: "NHL")!
        }
        if sportrow == 2 {
            LogoView.image = UIImage(named: "NBA")!
        }
        if sportrow == 3 {
            LogoView.image = UIImage(named: "MLB")!
        }
        if sportrow == 4 {
            LogoView.image = UIImage(named: "NFL")!
        }
        

    }
    


    @IBAction func goToLeagueApp(_ sender: Any) {
        if (sportrow == 0) {
            if(UIApplication.shared.canOpenURL(URL(string: "mls://")!)){
                //open the app with this URL scheme
                UIApplication.shared.open(URL(string: "mls://")!, options: [:], completionHandler: nil)
            } else {UIApplication.shared.open(URL(string: "sportscenter://")!, options: [:], completionHandler: nil)
            }
        }
        if (sportrow == 1) {
            if(UIApplication.shared.canOpenURL(URL(string: "nhl://")!)){
                //open the app with this URL scheme
                UIApplication.shared.open(URL(string: "nhl://")!, options: [:], completionHandler: nil)
            } else {UIApplication.shared.open(URL(string: "sportscenter://")!, options: [:], completionHandler: nil)
            }
        }
        if (sportrow == 2) {
            if(UIApplication.shared.canOpenURL(URL(string: "nba://")!)){
                //open the app with this URL scheme
                UIApplication.shared.open(URL(string: "nba://")!, options: [:], completionHandler: nil)
            } else {UIApplication.shared.open(URL(string: "sportscenter://")!, options: [:], completionHandler: nil)
            }
        }
        if (sportrow == 3) {
            if(UIApplication.shared.canOpenURL(URL(string: "atbat12://")!)){
                //open the app with this URL scheme
                UIApplication.shared.open(URL(string: "atbat12://")!, options: [:], completionHandler: nil)
            } else {UIApplication.shared.open(URL(string: "sportscenter://")!, options: [:], completionHandler: nil)
            }
        }
        if (sportrow == 4) {
            if(UIApplication.shared.canOpenURL(URL(string: "nflmobile://")!)){
                //open the app with this URL scheme
                UIApplication.shared.open(URL(string: "nflmobile://")!, options: [:], completionHandler: nil)
            } else {UIApplication.shared.open(URL(string: "sportscenter://")!, options: [:], completionHandler: nil)
            }
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

