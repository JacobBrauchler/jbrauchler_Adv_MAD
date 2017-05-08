//
//  BackendlessHelper.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 5/8/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation

class BackendlessHelper:NSObject {
    
    var backendless = Backendless.sharedInstance()
    func saveNewVehicle(realmvehicle: Vehicle) {
        
        let vehicle = backendlessVehicle()
        vehicle.make = realmvehicle.make
        vehicle.model = realmvehicle.model
        vehicle.year = realmvehicle.year
        
        let dataStore = backendless?.data.of(backendlessVehicle.ofClass())
        
        // save object synchronously
        var error: Fault?
        let result = dataStore?.save(vehicle, fault: &error) as? backendlessVehicle
        if error == nil {
            print("Vehicle has been saved: \(result!.objectId)")
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
}
