//
//  Constants.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Collection {
        static let main = "Main"
    }
    
    struct Database {
        private static let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        private static let baseDir = paths.count > 0 ? paths[0] as String : NSTemporaryDirectory() as String
        
        static let path = baseDir + "YapDatabase.sqlite"
    }
    
    struct Segue {
        static let unwind = "UnwindToNotesVC"
    }
    
}
