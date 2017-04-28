//
//  vehicles.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 2/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation
import RealmSwift

class Vehicle : Object {
    dynamic var id = 0
    dynamic var make = String()
    dynamic var model = String()
    dynamic var year = String()
    let mpgs = List<Mpg>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
