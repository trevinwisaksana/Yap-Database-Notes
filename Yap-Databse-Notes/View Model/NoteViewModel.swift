//
//  NoteViewModel.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

protocol Updatable: class {
    func refresh()
}

final class NoteViewModel {
    
    //---- Properties ----//
    
    weak var delegate: Updatable?
    
    private var notes = [Note]() {
        didSet {
            delegate?.refresh()
        }
    }
    
    var databaseService = DatabaseService()
    var searchService = SearchService()
    
    //---- Note Methods ----//
    
    func getNote(at indexPath: IndexPath) -> Note {
        return notes[indexPath.row]
    }
    
    func numberOfNotes() -> Int {
        return notes.count
    }
    
    func retrieveNotes() {
        let connection = databaseService.newConnection()
        
        databaseService.notes(connection: connection) { (retrievedNotes) in
            if let retrievedNotes = retrievedNotes {
                self.notes = retrievedNotes
            }
        }
    }
    
    func delete(noteAt indexPath: IndexPath) {
        let connection = databaseService.newConnection()
        let note = getNote(at: indexPath)
        
        databaseService.remove(note: note, connection: connection) { (success) in
            self.notes.remove(at: indexPath.row)
        }
    }
    
    func search(noteTitle: String) {
        let connection = databaseService.newConnection()
        
        searchService.search(title: noteTitle, connection: connection) { (searchedNotes) in
            self.notes = searchedNotes
        }
    }
}
