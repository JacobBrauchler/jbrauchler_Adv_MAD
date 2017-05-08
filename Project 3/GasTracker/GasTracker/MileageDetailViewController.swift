//
//  MileageDetailViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 3/20/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class MileageDetailViewController: UIViewController {
    var vehicles = realm.objects(Vehicle.self)
    var selectedVehicle: Int = 0
    var selectedMileage: Int = 0
    var vehicle = Vehicle()
    var mileage = Mpg()

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mpgLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    @IBOutlet weak var gasStationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicle = vehicles[selectedVehicle]
        mileage = vehicle.mpgs[selectedMileage]
        dateLabel.text = mileage.dateForMpg
        mpgLabel.text = mileage.mpg
        //let year = mileage.userVehicle?.year
        vehicleLabel.text = "\(mileage.userVehicle!.year) \(mileage.userVehicle!.make) \(mileage.userVehicle!.model)"
        gasStationLabel.text = mileage.gasStation
        
        

        // Do any additional setup after loading the view.
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
