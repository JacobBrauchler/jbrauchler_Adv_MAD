//
//  Restaurant.swift
//  Restaurants
//
//  Created by Jacob Brauchler on 4/8/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation
import Firebase

class Restaurant {
    var name: String
    var type: String
    var url: String
    
    init(newname: String, newurl: String, newtype: String){
        name = newname
        url = newurl
        type = newtype
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: String]
        name = snapshotValue["name"]!
        url = snapshotValue["url"]!
        type = snapshotValue["type"]!
    }
    
}
