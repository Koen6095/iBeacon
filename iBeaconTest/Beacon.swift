//
//  Beacon.swift
//  iBeaconTest
//
//  Created by Koen Vestjens on 23/11/2017.
//  Copyright © 2017 Koen Vestjens. All rights reserved.
//

import CoreLocation

class Beacon {
    
    var uuid: UUID
    var name: String = ""
    var paintingId: Int = 0
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    
    init(uuid: UUID, name: String, paintingId: Int, majorValue: Int, minorValue: Int){
        self.uuid = uuid
        self.name = name
        self.paintingId = paintingId
        self.majorValue = CLBeaconMajorValue(majorValue)
        self.minorValue = CLBeaconMinorValue(minorValue)
    }
    
    func asBeaconRegion() -> CLBeaconRegion {
        return CLBeaconRegion(proximityUUID: uuid,
                              major: majorValue,
                              minor: minorValue,
                              identifier: String(paintingId))
    }
}
