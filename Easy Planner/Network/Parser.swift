//
//  Parser.swift
//  AST Admin
//
//  Created by Marcos Tirao on 5/30/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class Parser: NSObject {
    
    var json: Any?
    
    init(data: NSDictionary) {}

    
    init(json: Data) {
        do {
            self.json = try JSONSerialization.jsonObject(with: json as Data, options: JSONSerialization.ReadingOptions())
        }catch {
            print(error);
            self.json = nil
        }
    }
    
}
