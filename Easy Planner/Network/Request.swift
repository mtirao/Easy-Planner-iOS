//
//  Network.swift
//  Reddit
//
//  Created by OLX - Marcos Tirao on 4/6/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit


func makeRequest(url: String, parameters: [String : String]? = nil,  completion:@escaping (Data?) -> Void) {
    let network = Request.sharedInstance
    
    if let httpUrl = NSURL(string: url, relativeTo: nil) as? URL {
        network.makeRequest(httpUrl, paramaters: parameters, completion: completion)
    }else {
        completion(nil)
    }
    
}


class Request: NSObject {
    
    static let sharedInstance = Request()
    
    let defaultSession : URLSession
    
    override private init() {
        defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    
    fileprivate func makeRequest(_ url: URL, paramaters: [String : Any]? = nil,  completion:@escaping (Data?) -> Void) {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: paramaters!)
        
        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let err = error {
                print(err)
                completion(nil)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(data)
                }else {
                    completion(nil)
                }
                
            }
        }
        
        task.resume()
        
    }
    
    
}
