//
//  SaveViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 1/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class SaveViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var gasStation: UITextField!
    var vehicles = realm.objects(Vehicle.self)
    var calculationString: String!
    let date = Date()
    var selected: String = ""
    var result: String = ""
    let formatter = DateFormatter()
    var vehicleNames = [""]
    var model = ""
    
    @IBOutlet weak var MPGValue: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    @IBOutlet weak var dateValue: UILabel!

    
    
    var newMpg = Mpg()
    
    @IBAction func doneTapped(_ sender: Any) {
        if  (gasStation.text?.isEmpty)! {
            let alert = UIAlertController(title: "Wait", message: "You must fill out the entire form", preferredStyle: UIAlertControllerStyle.alert)
            
            //add an "Okay" button to the alert controller
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okayAction)
            
            //present the Alert
            self.present(alert, animated: true, completion: nil)
        }else {
            newMpg.date = dateValue.text!
            newMpg.mpg = MPGValue.text!
            newMpg.gasStation = gasStation.text!
//            if model == "" {
//                model = vehicles[0]
//            }
            DispatchQueue(label: "background").async {
                let realm = try! Realm()
                let vehicle = realm.objects(Vehicle.self).filter("model = '\(self.model)'").first
                self.newMpg.userVehicle = vehicle
                
                try! realm.write {
                    vehicle?.mpgs.append(self.newMpg)
                    realm.add(vehicle!, update: true)
                }
            }
        


            //let vehicle = realm.objects(Vehicle.self).filter("model = '\(newMpg.userVehicle?.model)'")
//            try! realm.write {
//                
//                //realm.add(newMpg)
//            }
        }
        performSegue(withIdentifier: "goToVehicles", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gasStation.delegate = self
        formatter.dateFormat = "MM.dd.yyyy"
        let result = formatter.string(from: date)
        MPGValue.text = calculationString
        dateValue.text = result
        for Vehicle in vehicles {
            let vehicleName = "\(Vehicle.model)"
            vehicleNames.append(vehicleName)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return (vehicleNames.count)
    }
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
        Int) -> String? {
        return vehicleNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        model = vehicleNames[row]
    }
    
    



}


