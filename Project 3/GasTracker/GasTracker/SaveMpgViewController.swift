//
//  SaveMpgViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/3/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class SaveMpgViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mpgTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!

    @IBOutlet weak var gasStationTextField: UITextField!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    
    var vehicles = realm.objects(Vehicle.self)
    var model = ""
    var selected: String = ""
    var vehicleNames = [""]

    var newMpg = Mpg()
    
    @IBAction func addTapped(_ sender: Any) {
        if  (gasStationTextField.text?.isEmpty)! || (dateTextField.text?.isEmpty)! || (mpgTextField.text?.isEmpty)!{
            let alert = UIAlertController(title: "Wait", message: "You must fill out the entire form", preferredStyle: UIAlertControllerStyle.alert)
            
            //add an "Okay" button to the alert controller
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okayAction)
            
            //present the Alert
            self.present(alert, animated: true, completion: nil)
        }else {
            newMpg.date = dateTextField.text!
            newMpg.mpg = ("\(mpgTextField.text!) MPG")
            newMpg.gasStation = gasStationTextField.text!
            DispatchQueue(label: "background").async {
                let realm = try! Realm()
                let vehicle = realm.objects(Vehicle.self).filter("model = '\(self.model)'").first
                self.newMpg.userVehicle = vehicle
                self.newMpg.id = (vehicle?.mpgs.count)! + 1
                try! realm.write {
                    vehicle?.mpgs.append(self.newMpg)
                    realm.add(vehicle!, update: true)
                }
            }
            performSegue(withIdentifier: "goToVehicles", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gasStationTextField.delegate = self
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
