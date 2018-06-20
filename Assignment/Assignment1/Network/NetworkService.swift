//
//  NetworkService.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/13/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import Foundation
import SWXMLHash
protocol NetworkService {
    var baseURL: URL{get set}
    func methodType() ->String
    func methodName() ->String
    func headers()->Dictionary<String,String>
    func url()-> URL
    func requestTheServer(success: @escaping SuccessHandler, failure: @escaping FailureHandler)
}

extension NetworkService {

    func headers()->Dictionary<String,String>{
        return [:]
    }
    func url()-> URL {
        return URL(string: "\(baseURL)\(methodName().trimmingCharacters(in: .whitespacesAndNewlines))")!
    }
    public func requestTheServer(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        print(url())
        
        var urlRequest = URLRequest(url: url(), cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        urlRequest.httpMethod = methodType()
        
        for (key, value) in headers() {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (error != nil) {
                failure(response, data as AnyObject?, error)
            } else {
                if let json = data {
                    DispatchQueue.main.async {
                        let string = String(data: json, encoding: String.Encoding.utf8)
                        success(string as AnyObject)
                    }
                }
                
            }
        }
        task.resume()
    }
}
