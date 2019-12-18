//
//  WeatherStation.swift
//  Smart Building
//
//  Created by admin on 16/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

struct WeatherStation {
    var temperature: Int = 0
    var humidity: Int = 0
    var rainfall: Int = 0
    var speed: Int = 0
    var direction: Int = 0
    var time: String = ""
    
//    init(temperature: Int) {
//        self.temperature = temperature
//    }
    
    mutating func updateValues() {
        temperature = 11
        humidity = 22
        rainfall = 33
        speed = 44
        direction = 55
        time = "Waiting for time"
        
    }
}

