//
//  NotesViewController.swift
//  Yap-Databse-Notes
//
//  Created by Trevin Wisaksana on 04/05/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class NotesViewController: UIViewController {
    
    //---- Properties ----//
    
    var viewModel = NoteViewModel()
    
    //---- IBOutlets ----//
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //---- VC Lifecycle ----//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.retrieveNotes()
    }
    
    
    //---- IBAction ----//
    
    @IBAction func unwind(segue: UIStoryboardSegue) {}
    
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNotes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteCell = tableView.dequeueReusableCell()
        
        let note = viewModel.getNote(at: indexPath)
        cell.configure(with: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.delete(noteAt: indexPath)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let createNoteVC = storyboard.instantiateViewController(withIdentifier: "CreateNoteVC") as! CreateNoteViewController
        
        let noteSelected = viewModel.getNote(at: indexPath)
        createNoteVC.viewModel.note = noteSelected
        
        (parent as! UINavigationController).pushViewController(createNoteVC, animated: true)
    }
    
}

extension NotesViewController: UISearchBarDelegate {
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.search(noteTitle: searchBar.text ?? "")
//    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    }
    
}

extension NotesViewController: Updatable {
    
    func refresh() {
        tableView.reloadData()
    }
    
}
