//
//  Network.swift
//  Reddit
//
//  Created by OLX - Marcos Tirao on 4/6/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

enum HTTPMethod : String {
    case GET = "GET"
    case POST = "POST"
}

func makeRequest(url: String, method:HTTPMethod = .GET, parameters: [String : String]? = nil,  completion:@escaping (NSData?) -> Void) {
    let network = Request.sharedInstance
    
    if let httpUrl = NSURL(string: url, relativeTo: nil) {
        network.makeRequest(url: httpUrl, method: method, paramaters: parameters, completion: completion)
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
    
    
    fileprivate func makeRequest(url: NSURL, method:HTTPMethod = .GET, paramaters: [String : String]? = nil,  completion:@escaping (NSData?) -> Void) {
        
        var urlEncoded = url
        var request : NSMutableURLRequest?
        
        if method == .GET {
            if let param = paramaters {
                urlEncoded = self.encodeGetParameters(url: url, parameters: param)
                request = NSMutableURLRequest(url: urlEncoded as URL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            }
        }else {
            if let param = paramaters,  let encodeParam = encodePostParameters(parameters: param) {
                request = NSMutableURLRequest(url: urlEncoded as URL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
                request!.httpBody = encodeParam as Data
            }
        }
        
        //let request = NSMutableURLRequest(URL: urlEncoded, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 60)
        request!.httpMethod = method.rawValue
        
        let dataTask = defaultSession.dataTask(with: request! as URLRequest) {
            data, response, error in
            
            if let error = error {
                print(error)
                completion(nil)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(data as NSData?)
                }else {
                    completion(nil)
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func encodeParameters(parameters: [String: String]) -> String {
        
        var param :String = ""
        
        for (key, value) in parameters {
            param += "\(key)=\(value)&"
        }
        param = param.substring(to: param.index(before: param.endIndex))
        
        return param
    }
    
    private func encodeGetParameters(url: NSURL, parameters: [String : String]) -> NSURL {
        
        if (url.absoluteString?.contains("?"))!  {
            return NSURL(string:url.absoluteString! + encodeParameters(parameters: parameters))!
        }else {
            return NSURL(string:url.absoluteString! + "?" + encodeParameters(parameters: parameters))!
        }
    }
    
    private func encodePostParameters(parameters: [String : String]) -> NSData? {
        let param = encodeParameters(parameters: parameters)
        
        return param.data(using: String.Encoding.utf8) as NSData?
        
    }
    
    
}
