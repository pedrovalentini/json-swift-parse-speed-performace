//
//  SpeedArgo.swift
//  JSONSpeed
//
//  Created by Pedro Valentini on 22/03/16.
//  Copyright © 2016 Mobicare. All rights reserved.
//

import UIKit
import ObjectMapper

class SpeedObjectMapper: Mappable {
    
    var name: String? = nil
    var list: [SpeedObjectMapper]? = nil
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        list <- map["list"]
    }
    
    
}
