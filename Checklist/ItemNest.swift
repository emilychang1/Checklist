//
//  ItemNest.swift
//  Checklist
//
//  Created by Emily Chang on 7/20/17.
//  Copyright © 2017 Emily Chang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class ItemNest: NSObject, NSCoding {
    
    
    //MARK: Properties
    
    var name: String
    var nest: ItemNest?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
    
    struct PropertyKey {
        static let name = "name"
        //static let completed = "completed"
        static let nest = "nest"
    }
    
    init(name: String, nest: ItemNest?) {
        self.name = name
        //self.completed = completed
        self.nest = nest
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        //aCoder.encode(completed, forKey: PropertyKey.completed)
        aCoder.encode(nest, forKey: PropertyKey.nest)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        
        
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Item object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        //let completed = aDecoder.decodeBool(forKey: PropertyKey.completed)
        let nest = aDecoder.decodeObject(forKey: PropertyKey.nest)

        
        // Must call designated initializer.
        self.init(name: name, nest: nest as! ItemNest)
    }
}
