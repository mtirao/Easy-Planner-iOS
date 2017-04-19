//
//  Network.swift
//  Reddit
//
//  Created by Marcos Tirao on 4/6/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import Foundation


func makeRequest(url: String, parameters: [String : String]? = nil,  completion:@escaping (Data?) -> Void) {
    
    if let httpUrl = NSURL(string: url, relativeTo: nil) as URL? {
        
        // create post request
        var request = URLRequest(url: httpUrl)
        request.httpMethod = "POST"
        
        // insert json data to the request
        if let postParameters = parameters,  let jsonData = try? JSONSerialization.data(withJSONObject: postParameters) {
            request.httpBody = jsonData
        }
    
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
        
    }else {
        completion(nil)
    }
    
}
