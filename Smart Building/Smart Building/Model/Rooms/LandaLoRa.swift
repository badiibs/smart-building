//
//  LandaLoRa.swift
//  Smart Building
//
//  Created by admin on 19/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct LandaLora: Codable  {
    struct object: Codable {
        let Temperature: String
        let Humidity: String
        let Moisture: String
        let WaterSensor: String
        let Time: String
        let Battery_Level: Double
    }
    let object: object
}
