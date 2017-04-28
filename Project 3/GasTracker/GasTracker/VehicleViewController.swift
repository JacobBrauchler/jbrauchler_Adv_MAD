//
//  VehicleViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 2/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import RealmSwift

class VehicleViewController: UITableViewController {
    
    var vehicles = realm.objects(Vehicle.self)
    
    @IBAction func unwindToVehicles(segue: UIStoryboardSegue){
        readAndUpdate()
        
    }
    
    func readAndUpdate(){
        vehicles = realm.objects(Vehicle.self)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAndUpdate()
    }

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
        return vehicles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VehicleCell

        let vehicle = vehicles[indexPath.row]
        cell.makeLabel?.text = vehicle.make
        cell.modelLabel?.text = vehicle.model
        cell.yearLabel?.text = vehicle.year
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
            try! realm.write {
                realm.delete(vehicles[indexPath.row])
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vehicleData" {
            let detailVC = segue.destination as! DataViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            //sets the data for the destination controller
            let vehicle = vehicles[indexPath.row]
            detailVC.title = "\(vehicle.year) \(vehicle.make) \(vehicle.model)"
            detailVC.vehicle = vehicle
            //detailVC.mileages = vehicle.mpgs
            detailVC.selectedVehicle = indexPath.row
        } //for detail disclosure
    }

 

}
