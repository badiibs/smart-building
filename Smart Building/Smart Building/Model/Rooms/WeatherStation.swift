//
//  WeatherStation.swift
//  Smart Building
//
//  Created by admin on 16/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

 
struct WeatherStation: Codable {
    struct object: Codable {
        let Temperature: Double
        let RH: Double
        let Time: String
        let direction: Int
        let rainfall: Int
        let speed: Int
    }

    let object: object
}

