//
//  DataViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 2/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class DataViewController: UITableViewController {
    
    @IBOutlet var DataView: UITableView!
    //var mileages = realm.objects(Mpg.self)
    var backendless = Backendless.sharedInstance()
    var vehicles = realm.objects(Vehicle.self)
    var selectedVehicle: Int = 0
    var vehicle = Vehicle()

    
    func readAndUpdate(){
        //mileages = realm.objects(Mpg.self)
        tableView.reloadData()
    }
    
    @IBAction func unwindToData(segue: UIStoryboardSegue){
        readAndUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicle = vehicles[selectedVehicle]
        readAndUpdate()    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vehicle.mpgs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MpgCell
        
        let mileage = vehicle.mpgs[indexPath.row]
        cell.mpgLabel?.text = mileage.mpg
        cell.vehicleLabel?.text = mileage.userVehicle?.model
        cell.gasStationLabel?.text = mileage.gasStation
        cell.dateLabel?.text = mileage.dateForMpg

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var Mpg = vehicle.mpgs[indexPath.row]
            deleteMpg(realmMpg: Mpg)
            try! realm.write {
                realm.delete(Mpg)
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteMpg(realmMpg: Mpg) {
        
        let mpg = backendlessMpg()
        mpg.dateForMpg = realmMpg.dateForMpg
        mpg.gasStation = realmMpg.gasStation
        mpg.mpg = realmMpg.mpg
        mpg.objectId = realmMpg.objectId
//        vehicle.make = realmVehicle.make
//        vehicle.model = realmVehicle.model
//        vehicle.year = realmVehicle.year
//        vehicle.objectId = realmVehicle.objectId
        
        let dataStore = backendless?.data.of(backendlessMpg.ofClass())
        var error: Fault?
        
        let savedMpg = dataStore?.save(mpg, fault: &error) as? backendlessMpg
        if error == nil {
            print("Mpg has been saved: \(savedMpg!.objectId)")
            
            // now delete the saved object
            let result = dataStore?.remove(savedMpg, fault: &error)
            if error == nil {
                print("Mpg has been deleted: \(result)")
            }
            else {
                print("Server reported an error (2): \(error)")
            }
        }
        else {
            print("Server reported an error (1): \(error)")
        }
    }
 
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mileageDetail" {
            let detailVC = segue.destination as! MileageDetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            //sets the data for the destination controller
            let vehicle = vehicles[indexPath.row]
            //detailVC.title = "\(vehicle.year) \(vehicle.make) \(vehicle.model)"
            detailVC.vehicle = vehicle
            detailVC.selectedMileage = indexPath.row
            //detailVC.mileages = vehicle.mpgs
            detailVC.selectedVehicle = selectedVehicle
        } //for detail disclosure
    }

}
