//
//  Painting.swift
//  iBeaconTest
//
//  Created by Koen Vestjens on 23/11/2017.
//  Copyright © 2017 Koen Vestjens. All rights reserved.
//

import Foundation

class Painting{
    
    var id: Int = 0
    var name: String = ""
    var info: String = ""
    var img: String = ""
    var painter: String = ""
    
    init(id: Int, name: String, info: String, img: String, painter: String){
        self.id = id
        self.name = name
        self.info = info
        self.img = img
        self.painter = painter
    }
}
