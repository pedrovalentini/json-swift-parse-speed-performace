//
//  Speed.swift
//  MinhaOi
//
//  Created by Pedro Valentini on 21/03/16.
//  Copyright © 2016 Mobicare. All rights reserved.
//

import UIKit
//import Argo
//import Curry
//import Tailor
//import ObjectMapper
import Unbox


class SpeedUnbox: Unboxable {
    
    var name: String? = nil
    var list: [SpeedUnbox]? = nil
    
    
    required init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
        self.list = unboxer.unbox("list")
    }
    
}

