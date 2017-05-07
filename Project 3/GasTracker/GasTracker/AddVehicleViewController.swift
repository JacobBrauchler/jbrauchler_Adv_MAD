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
    
    var vehicles = realm.objects(Vehicle.self)
    var newVehicle = Vehicle()
    
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
