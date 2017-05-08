
//
//  AddVehicleViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 1/24/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class AddVehicleViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var make: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var year: UITextField!
    var backendless = Backendless.sharedInstance()
    var vehicles = realm.objects(Vehicle.self)
    var newVehicle = Vehicle()
    var id = ""
    
    @IBAction func doneTapped(_ sender: Any) {
        if  (make.text?.isEmpty)! || (model.text?.isEmpty)! || (year.text?.isEmpty)! {
            let alert = UIAlertController(title: "Wait", message: "You must fill out the entire form", preferredStyle: UIAlertControllerStyle.alert)
            
            //add an "Okay" button to the alert controller
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okayAction)
            
            //present the Alert
            self.present(alert, animated: true, completion: nil)
        }else {

            newVehicle.make = make.text!
            newVehicle.model = model.text!
            newVehicle.year = year.text!
            newVehicle.id = vehicles.count + 1
            saveNewVehicle(realmvehicle: newVehicle)
            newVehicle.objectId = id
            
            //save variable to the database
            try! realm.write {
                realm.add(newVehicle)
                
            }
            performSegue(withIdentifier: "goToVehicles", sender: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        make.delegate = self
        model.delegate = self
        year.delegate = self

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
    
    //var backendless = Backendless.sharedInstance()
    func saveNewVehicle(realmvehicle: Vehicle) {
        
        let vehicle = backendlessVehicle()
        vehicle.make = realmvehicle.make
        vehicle.model = realmvehicle.model
        vehicle.year = realmvehicle.year
        //vehicle.mpgs = [backendlessMpg]()
        let dataStore = backendless?.data.of(backendlessVehicle.ofClass())
        
        // save object synchronously
        var error: Fault?
        let result = dataStore?.save(vehicle, fault: &error) as? backendlessVehicle
        if error == nil {
            print("Vehicle has been saved: \(result!.objectId)")
            id = result!.objectId!
        }
        else {
            print("Server reported an error: \(error)")
        }
        
        // save object asynchronously
        //        dataStore.save(
        //            contact,
        //            response: { (result: AnyObject!) -> Void in
        //                let obj = result as! Contact
        //                print("Contact has been saved: \(obj.objectId)")
        //        },
        //            error: { (fault: Fault!) -> Void in
        //                print("fServer reported an error: \(fault)")
        //        })
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
