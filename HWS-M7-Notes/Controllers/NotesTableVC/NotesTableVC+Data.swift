//
//  NotesTableVC+Data.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/29/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import Foundation

extension NotesTableVC {
    
    // MARK: - Data Manipulation Methods
    
    func populateNotesArrayWithSavedNotes() {
        let defaults = UserDefaults.standard
        
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                fatalError("Unable to load saved notes.")
            }
        }
    }
    
}
