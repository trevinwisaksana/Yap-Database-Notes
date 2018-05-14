//
//  Note.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class Note: NSObject, NSCoding {
    
    var title: String
    var content: String
    var modificationTime = Date()
    var id: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.id = String(arc4random())
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(modificationTime, forKey: "modificationTime")
        aCoder.encode(id, forKey: "id")
    }
    
    init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        content = aDecoder.decodeObject(forKey: "content") as! String
        modificationTime = aDecoder.decodeObject(forKey: "modificationTime") as! Date
        id = aDecoder.decodeObject(forKey: "id") as! String
    }
    
}
