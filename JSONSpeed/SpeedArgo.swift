//
//  SpeedArgo.swift
//  JSONSpeed
//
//  Created by Pedro Valentini on 22/03/16.
//  Copyright © 2016 Mobicare. All rights reserved.
//

import UIKit
import Argo
import Curry


struct SpeedArgo {
    let name: String
    let list: [SpeedArgo]
}

extension SpeedArgo: Decodable {
    static func decode(j: JSON) -> Decoded<SpeedArgo> {
        return curry(SpeedArgo.init)
            <^> j <| "name"
            <*> j <|| "list"
    }
}
