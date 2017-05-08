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
    var backendless = Backendless.sharedInstance()
    var vehicles = realm.objects(Vehicle.self)
    var mpgs = realm.objects(Mpg.self)
    var calculationString: String!
    let date = Date()
    var selected: String = ""
    var result: String = ""
    let formatter = DateFormatter()
    var vehicleNames = [""]
    var model = ""
    var id = ""
    
    @IBOutlet weak var MPGValue: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    @IBOutlet weak var dateValue: UILabel!

    
    
    var newMpg = Mpg()
    var newBackendlessMpg = backendlessMpg()
    
    @IBAction func doneTapped(_ sender: Any) {
        if  (gasStation.text?.isEmpty)! {
            let alert = UIAlertController(title: "Wait", message: "You must fill out the entire form", preferredStyle: UIAlertControllerStyle.alert)
            
            //add an "Okay" button to the alert controller
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okayAction)
            
            //present the Alert
            self.present(alert, animated: true, completion: nil)
        }else {
            newMpg.dateForMpg = dateValue.text!
            newMpg.mpg = MPGValue.text!
            newMpg.gasStation = gasStation.text!
            newMpg.id = (mpgs.count) + 1
            
            newBackendlessMpg.dateForMpg = dateValue.text!
            newBackendlessMpg.mpg = MPGValue.text!
            newBackendlessMpg.gasStation = gasStation.text!
            
            
            
//            if model == "" {
//                model = vehicles[0]
//            }
            DispatchQueue(label: "background").async {
                let realm = try! Realm()
                let vehicle = realm.objects(Vehicle.self).filter("model = '\(self.model)'").first
                self.updateVehicle(realmVehicle: vehicle!, mpg: self.newBackendlessMpg)
                self.newMpg.userVehicle = vehicle
                self.newMpg.objectId = self.id
                try! realm.write {
                    vehicle?.mpgs.append(self.newMpg)
                    realm.add(vehicle!, update: true)
                }
                
                
            }
        }
        
        performSegue(withIdentifier: "goToVehicles", sender: self)
        
    }
    
    
    func updateVehicle(realmVehicle: Vehicle, mpg: backendlessMpg) {
        
        let dataStore = Backendless.sharedInstance().data.of(Vehicle.ofClass())
        var error: Fault?
        let vehicle = backendlessVehicle()
        vehicle.make = realmVehicle.make
        vehicle.model = realmVehicle.model
        vehicle.year = realmVehicle.year
        //vehicle.mpgs.append(mpg)
        vehicle.objectId = realmVehicle.objectId
        mpg.userVehicle = vehicle
        let result = dataStore?.save(mpg, fault: &error) as? backendlessMpg
        let updatedVehicle = dataStore?.save(vehicle, fault: &error) as? backendlessVehicle
        if error == nil {
            print("Vehicle has been updated: \(updatedVehicle!.objectId)")
            id = (result?.objectId)!
        }
        else {
            print("Server reported an error (2): \(error)")
        }
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


