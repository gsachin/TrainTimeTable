//
//  StationDataByCode.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/13/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import Foundation
import SWXMLHash
struct StationDataByCode : NetworkService {
    var baseURL = URL(string: "http://api.irishrail.ie/realtime/realtime.asmx/")!
    var code = ""
    public var stationDataItems:[StationData]
    init() {
        stationDataItems = [StationData]()
    }
    func methodType() ->String {
        return "GET"
    }
    func methodName() ->String {
        return "getStationDataByCodeXML?StationCode=\(code)"
    }
    
    func headers()->Dictionary<String,String>{
        return [:]
    }
    mutating func parse(response : Any?){
        let xml = SWXMLHash.parse(response as? String ?? "")
        self.stationDataItems.removeAll()
        
        do {
            self.stationDataItems = try xml["ArrayOfObjStationData"]["objStationData"].value()
            let array = self.stationDataItems
            self.stationDataItems.removeAll()
            array.forEach({ (stationdata) in
                self.stationDataItems.append(stationdata)
                
            })
            
        } catch {
            print("unable to parse the XML")
        }
        
    }
}
