//
//  SearchService.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 13/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

class SearchService {
    
    func setupFullTextSearchExtension() {
        let ftsHandler = YapDatabaseFullTextSearchHandler()
        let block = ftsHandler.blockType as! YapDatabaseFullTextSearchWithObjectBlock
        
//        block.(let dictionary, let collection, let key, let object)
        
        let fts = YapDatabaseFullTextSearch(columnNames: ["title"], handler: ftsHandler)
        database.register(fts, withName: "fts")
    }
    
    func search(title: String, connection: YapDatabaseConnection, completion: @escaping ([Note]) -> Void) {
        var notes = [Note]()
   
        connection.read { (transaction) in
            (transaction.extension("fts") as! YapDatabaseFullTextSearchTransaction).enumerateKeysAndObjects(matching: title) { (_, _, object, _) in
                let note = object as! Note
                notes.append(note)
                completion(notes)
            }
        }
    }
    
}
