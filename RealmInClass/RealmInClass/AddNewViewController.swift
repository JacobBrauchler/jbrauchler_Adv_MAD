//
//  AddNewViewController.swift
//  RealmInClass
//
//  Created by Jacob Brauchler on 2/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewViewController: UIViewController {

    @IBOutlet weak var songTextField: UITextField!
    
    @IBOutlet weak var artistTextField: UITextField!
    
    @IBOutlet weak var albumTextField: UITextField!
    
    var newSong = Song()
    
    @IBAction func saveTapped(_ sender: Any) {
        
        newSong.title = songTextField.text!
        newSong.artist = artistTextField.text!
        newSong.album = albumTextField.text!
        
        //save variable to the database
        try! realm.write {
            realm.add(newSong)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
