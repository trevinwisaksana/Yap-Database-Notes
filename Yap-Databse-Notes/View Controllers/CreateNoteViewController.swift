//
//  CreateNoteViewController.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class CreateNoteViewController: UIViewController {
    
    //---- IBOutlets ----//
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    
    //---- Properties -----//
    
    var viewModel = CreateNoteViewModel()
    
    //---- VC Lifecycle ----//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let noteSelected = viewModel.note {
            noteTitleTextField.text = noteSelected.title
            noteContentTextView.text = noteSelected.content
        } else {
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
        
    }
    
    //---- IBAction ----//
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        if let noteTitle = noteTitleTextField.text, noteTitle != "", viewModel.note == nil {
            viewModel.save(noteTitle: noteTitle, content: noteContentTextView.text) {
                self.performSegue(withIdentifier: Constants.Segue.unwind, sender: self)
            }
        } else if let noteTitle = noteTitleTextField.text, viewModel.note != nil {
            viewModel.update(noteTitle: noteTitle, content: noteContentTextView.text) {
                self.performSegue(withIdentifier: Constants.Segue.unwind, sender: self)
            }
        }
    }
    
}
