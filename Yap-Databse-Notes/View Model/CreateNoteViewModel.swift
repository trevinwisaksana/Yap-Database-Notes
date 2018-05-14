//
//  CreateNoteViewModel.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

class CreateNoteViewModel {
    
    var databaseService = DatabaseService()
    var note: Note?
    
    func save(noteTitle: String, content: String, completion: @escaping () -> Void) {
        note = Note(title: noteTitle, content: content)
        
        let connection = databaseService.newConnection()
        
        guard let savedNote = note else {
            return
        }

        databaseService.save(note: savedNote, connection: connection) { _ in
            completion()
        }
    }
    
    func update(noteTitle: String, content: String, completion: @escaping () -> Void) {
        let newNote = Note(title: noteTitle, content: content)
        
        let connection = databaseService.newConnection()
        
        guard let note = note else {
            return
        }
        
        databaseService.update(note: note, with: newNote, connection: connection) { _ in
            completion()
        }
    }
    
}
