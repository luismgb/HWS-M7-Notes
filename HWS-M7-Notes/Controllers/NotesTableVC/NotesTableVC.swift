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
    
    var notes = [Note]()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notes"
        
        // Removes empty extra cells at bottom of the tableView
        tableView.tableFooterView = UIView()
        
        setupBackground()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableView))
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let noteBeingMoved = notes.remove(at: fromIndexPath.row)
        notes.insert(noteBeingMoved, at: to.row)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc func editTableView() {
        tableView.isEditing.toggle()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
