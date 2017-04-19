//
//  Parser.swift
//  AST Admin
//
//  Created by Marcos Tirao on 5/30/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import Foundation

class Parser {
    
    var json: Any?
    var status: Int?
    var message: String?
    
    
    init(data: NSDictionary) {}

    
    init(json: Data) {
        do {
            self.json = try JSONSerialization.jsonObject(with: json as Data, options: JSONSerialization.ReadingOptions())
            
            if let jsonLogin = self.json as? [String:Any] {
                
                let status = jsonLogin["status"] as! NSString
                self.status = status.integerValue
                
                self.message = jsonLogin["message"] as? String
            }
            
        }catch {
            print(error);
            self.json = nil
        }
    }
    
}
