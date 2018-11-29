//
//  DetailVC+Data.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/29/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import Foundation

extension DetailVC {
    
    // MARK: - Data Manipulation Methods
    
    /// Loads the notes from user defaults and assigns them to the notes property.
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
    
    /// Saves the notes array into the user defaults.
    func saveNotes() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            fatalError("Failed to save notes into user defaults.")
        }
    }
    
}
