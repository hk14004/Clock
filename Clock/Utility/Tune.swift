//
//  Tune.swift
//  Clock
//
//  Created by Hardijs on 28/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class Tune: NSObject, NSCoding {
    
    let name: String
    let format: String
    
    init(name: String, format: String) {
        self.name = name
        self.format = format
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(format, forKey: "format")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        format = coder.decodeObject(forKey: "format") as! String
    }
}
