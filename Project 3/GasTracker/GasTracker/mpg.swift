//
//  mpg.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 2/28/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation
import RealmSwift

class Mpg : Object {
    dynamic var id = 0
    dynamic var mpg = String()
    dynamic var gasStation = String()
    dynamic var dateForMpg = String()
    dynamic var objectId = String()
//    dynamic var price = String()
//    dynamic var fuelGrade = String()
    dynamic var userVehicle: Vehicle?
    override class func primaryKey() -> String? {
        return "id"
    }
    //let userVehicle = LinkingObjects(fromType: Vehicle.self, property: "mpgs")
}

class backendlessMpg : NSObject {
    var objectId : String?
    var mpg = String()
    var gasStation = String()
    var dateForMpg = String()
    var userVehicle = backendlessVehicle()
    
}
