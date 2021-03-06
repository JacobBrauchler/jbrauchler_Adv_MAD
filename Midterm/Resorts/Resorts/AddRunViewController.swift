//
//  AddRunViewController.swift
//  Resorts
//
//  Created by Jacob Brauchler on 3/16/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class AddRunViewController: UIViewController {

    @IBOutlet weak var runTextfield: UITextField!
    
    var addedRun = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
            if ((runTextfield.text?.isEmpty) == false){
                addedRun=runTextfield.text!
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
