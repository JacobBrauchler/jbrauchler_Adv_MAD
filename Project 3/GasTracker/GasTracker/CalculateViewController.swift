//
//  CalculateViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 1/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate {

        
    @IBOutlet weak var miles: UITextField!
    @IBOutlet weak var MPG: UILabel!
    @IBOutlet weak var gallons: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var gallonsTotal: Float32!
    var milesDriven: Float32!
    var calculation: Float32!
    var Value: Float32!
    var calculationString: String!
    
    @IBAction func unwindToCalculate(segue: UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miles.delegate = self
        gallons.delegate = self
        MPG.text = ""
        // Do any additional setup after loading the view, typically from a nib.
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
    

    
    @IBAction func Calculate() {
        self.view.endEditing(true)
        getVariables()
        Value = calculategasmileage()
        let calculationString = (NSString(format: "%.2f", Value) as String) + " MPG"
        self.MPG.text = calculationString
        self.saveButton.isHidden=false
        miles.text = ""
        gallons.text = ""
        
    }
    
    //get string from UITextField
    func getVariables(){
        //get desired string from UITextField convert to int
        milesDriven = NSString(string: miles.text!).floatValue
        gallonsTotal = NSString(string: gallons.text!).floatValue
        
        
    }
    
    
    func calculategasmileage() -> Float32 {
        calculation = milesDriven / gallonsTotal
        return calculation
        
    }
    
    
    @IBAction func saveData() {
      performSegue(withIdentifier: "Save", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            let myVC = segue.destination as! SaveViewController
            myVC.calculationString = MPG.text!
        }
        
    }
    
    
    
    
}
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


