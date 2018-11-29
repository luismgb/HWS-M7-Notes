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
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        setupBackground()
        
        // Setup NaigationController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableView))
        
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeNewNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [spacer, compose, spacer]
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.tintColor = Utilities.myBarTintColor
        
        #warning("Delete below this")
        notes.append(Note(text: "first"))
        notes.append(Note(text: "second"))
        
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            fatalError("Failed to save notes into user defaults.")
        }
        #warning("delete above this")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notes = Utilities.savedNotes()
        tableView.reloadData()
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
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func editTableView() {
        tableView.isEditing.toggle()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
        guard let detailVC = segue.destination as? DetailVC else { fatalError() }
        detailVC.selectedNoteIndex = indexPath.row
    }
    
    @objc func composeNewNote() {
        #warning("Add Functionality")
    }
    
}
