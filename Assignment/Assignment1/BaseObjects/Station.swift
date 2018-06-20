//
//  Station.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/12/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import Foundation
import Foundation
import SWXMLHash

struct Station :XMLIndexerDeserializable {
    
    let stationId: Int
    let name: String
    let alias: String
    let latitude: Double
    let longitude: Double
    let code: String
    
    static func deserialize(_ node: XMLIndexer) throws -> Station {
        return try Station(
            stationId: node["StationId"].value(),
            name: node["StationDesc"].value(),
            alias: node["StationAlias"].value(),
            latitude: node["StationLatitude"].value(),
            longitude: node["StationLongitude"].value(),
            code: node["StationCode"].value()
        )
    }
}
