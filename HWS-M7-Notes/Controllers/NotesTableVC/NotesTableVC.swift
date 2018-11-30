//
//  NotesTableVC.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/27/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

class NotesTableVC: UITableViewController {

    // MARK: - Properties
    
    var notes: [Note]!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notes = Utilities.savedNotes()
        
        title = "Notes"
        
        // Removes empty extra cells at bottom of the tableView
        tableView.tableFooterView = UIView()
        tableView.backgroundView = Utilities.backgroundImageView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // Setup NaigationController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableView))
        
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeNewNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [spacer, compose, spacer]
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.tintColor = Utilities.myBarTintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notes = Utilities.savedNotes()
        tableView.reloadData()
        // When user creates a new note while the editing the tableView,
        // this ensures that when the user comes back to NotesTableVC, the
        // tableView is not in editing mode anymore.
        tableView.isEditing = false
    }

    // MARK: - Table View Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].text
        
        let dateFormatter = customDateFormatter()
        
        let noteDate = notes[indexPath.row].dateLastModified
        let formattedDate = dateFormatter.string(from: noteDate)
        cell.detailTextLabel?.text = formattedDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            Utilities.save(notes)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let noteBeingMoved = notes.remove(at: fromIndexPath.row)
        notes.insert(noteBeingMoved, at: to.row)
        Utilities.save(notes)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailVC", sender: self)
    }
    
    @objc func editTableView() {
        tableView.isEditing.toggle()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let noteIndex: Int
        if let indexPath = tableView.indexPathForSelectedRow {
            // If there is a cell selected in the tableView, we use the row
            // indexPath to access the right note.
            noteIndex = indexPath.row
        } else {
            // If there is no cell selected in the tableView, like when we
            // create a new note, we use the notes array endIndex for the
            // selectedNoteIndex in the DetailVC.
            noteIndex = notes.endIndex
        }
        guard let detailVC = segue.destination as? DetailVC else { fatalError() }
        detailVC.selectedNoteIndex = noteIndex
    }
    
    @objc func composeNewNote() {
        performSegue(withIdentifier: "goToDetailVC", sender: self)
    }
    
}
