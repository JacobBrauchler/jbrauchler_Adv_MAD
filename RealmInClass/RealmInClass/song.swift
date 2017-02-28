//
//  song.swift
//  RealmInClass
//
//  Created by Jacob Brauchler on 2/23/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import Foundation
import RealmSwift

class Song : Object {
    dynamic var title = String()
    dynamic var artist = String()
    dynamic var album = String()
    dynamic var imageName = String()
}
