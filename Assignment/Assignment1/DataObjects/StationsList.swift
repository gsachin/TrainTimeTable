//
//  StationsList.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/12/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import Foundation
import SWXMLHash
struct StationList : NetworkService {
    var baseURL = URL(string: "http://api.irishrail.ie/realtime/realtime.asmx/")!
    
    public var stationItems:[Station]
    init() {
        stationItems = [Station]()
    }
    func methodType() ->String {
        return "GET"
    }
    func methodName() ->String {
        return "getAllStationsXML"
    }
    func params() -> [String: Any] {
        return [:]
    }
    func headers()->Dictionary<String,String>{
        return [:]
    }
    mutating func parse(response : Any?){
        let xml = SWXMLHash.parse(response as? String ?? "")
        self.stationItems.removeAll()
        
        do {
            self.stationItems = try xml["ArrayOfObjStation"]["objStation"].value()
            let array = self.stationItems
            self.stationItems.removeAll()
            array.forEach({ (station) in
                    self.stationItems.append(station)

            })
            
        } catch {
            print("Error parse of XML")
        }
        
    }
}
