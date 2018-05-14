//
//  DatabaseService.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

class DatabaseService {
    
    //---- Database Methods ----//
    
    // New Database Connection
    
    func newConnection() -> YapDatabaseConnection {
        let connection = database.newConnection()
        
        return connection
    }
    
    // Save Notes
    
    func save(note: Note, connection: YapDatabaseConnection, completion: @escaping (Bool) -> Void) {
        var success: Bool = false
        
        connection.readWrite { (transaction) in
            success = self.save(note: note, transaction: transaction)
            completion(success)
        }
    }
    
    private func save(note: Note, transaction: YapDatabaseReadWriteTransaction) -> Bool {
        transaction.setObject(note, forKey: note.id, inCollection: Constants.Collection.main)
        return true
    }
    
    // Retrieve Notes
    
    func notes(connection: YapDatabaseConnection, completion: @escaping ([Note]?) -> Void) {
        var array: [Note]?
        
        connection.read { (transaction) in
            array = self.notes(transaction: transaction)
            completion(array)
        }
    }
    
    private func notes(transaction: YapDatabaseReadTransaction) -> [Note]? {
        var notes = [Note]()
        
        transaction.enumerateKeysAndObjects(inCollection: Constants.Collection.main) { (_, object, _) in
            if let note = object as? Note {
                notes.append(note)
            }
        }
        
        return notes
    }
    
    // Update Notes
    
    func update(note: Note, with newNote: Note, connection: YapDatabaseConnection, completion: @escaping (Bool) -> Void) {
        var success: Bool = false

        connection.readWrite { (transaction) in
            success = self.update(currentNote: note, with: newNote, transaction: transaction)
            completion(success)
        }
    }
    
    private func update(currentNote: Note, with newNote: Note, transaction: YapDatabaseReadWriteTransaction) -> Bool {
        transaction.replace(newNote, forKey: currentNote.id, inCollection: Constants.Collection.main)
        return true
    }
    
    // Remove Note
    
    func remove(note: Note, connection: YapDatabaseConnection, completion: @escaping (Bool) -> Void) {
        var success: Bool = false
      
        connection.readWrite { (transaction) in
            success = self.remove(note: note, transaction: transaction)
            completion(success)
        }
    }
    
    private func remove(note: Note, transaction: YapDatabaseReadWriteTransaction) -> Bool {
        transaction.removeObject(forKey: note.id, inCollection: Constants.Collection.main)
        return true
    }
    
}
