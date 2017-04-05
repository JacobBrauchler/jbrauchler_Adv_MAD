//
//  Recipe.swift
//  recipes
//
//  Created by Jacob Brauchler on 3/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation
import Firebase

class Recipe {
    var name: String
    var url: String
    
    init(newname: String, newurl: String){
        name = newname
        url = newurl
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: String]
        name = snapshotValue["name"]!
        url = snapshotValue["url"]!
    }
    
}
