//
//  StationData.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/13/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import Foundation
import SWXMLHash

struct StationData :XMLIndexerDeserializable  {
    
    var trainCode: String?
    var queryTime: String?
    var origin: String?
    var destination: String?
    var status: String?
    var schreduleDeparture: String?
    var trainType: String?
    
    
    init() {
        self.trainCode = ""
        self.queryTime = ""
        self.origin = ""
        self.destination = ""
        self.status = ""
        self.schreduleDeparture = ""
        self.trainType = ""
        
    }

    init(trainCode: String?, queryTime: String?, origin: String?, destination: String?, status: String?, schreduleDeparture: String?, trainType: String?) {
        self.trainCode = trainCode
        self.queryTime = queryTime
        self.origin = origin
        self.destination = destination
        self.status = status
        self.schreduleDeparture = schreduleDeparture
        self.trainType = trainType

    }
    static func deserialize(_ node: XMLIndexer) throws -> StationData {
        return try StationData(
            trainCode: node["Traincode"].element?.text,
            queryTime: node["Querytime"].element?.text,
            origin: node["Origin"].element?.text,
            destination: node["Destination"].element?.text,
            status: node["Status"].element?.text,
            schreduleDeparture: node["Schdepart"].element?.text == "00:00" ? node["Scharrival"].element?.text : node["Schdepart"].element?.text,
            trainType: node["Traintype"].element?.text

        )
    }
}
