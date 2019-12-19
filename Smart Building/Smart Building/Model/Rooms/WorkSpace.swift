//
//  WorkSpace.swift
//  Smart Building
//
//  Created by admin on 19/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct WorkSpace: Codable  {
    struct object: Codable {
        let temperature: Double
        let humidity: Double
        let pressure: Double
        let Time: String
        let battery: Double
    }
    let object: object
}
