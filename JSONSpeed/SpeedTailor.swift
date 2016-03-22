//
//  SpeedTailor.swift
//  JSONSpeed
//
//  Created by Pedro Valentini on 22/03/16.
//  Copyright © 2016 Mobicare. All rights reserved.
//

import UIKit
import Tailor

class SpeedTailor: Mappable {

    var name: String? = nil
    var list: [SpeedTailor]? = nil
    
    required convenience init(_ map: [String : AnyObject]) {
        self.init()
        name <- map.property("name")
        list  <- map.property("list")
    }
    
}
