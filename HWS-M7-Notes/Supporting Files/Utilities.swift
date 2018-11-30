//
//  Utilities.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/28/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

class Utilities {
    
    // MARK: - Project Assets
    
    /// Dark yellow UIColor used to tint BarButtonItems.
    static let myBarTintColor = UIColor(red: 222.0/255.0, green: 176.0/255.0, blue: 0, alpha: 1)
    
    static func backgroundImageView() -> UIImageView {
        let backgroundImage = UIImage(named: "paperBackground")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        return backgroundImageView
    }
    
    // MARK: - Data Manipulation Methods
    
    /// Loads and return the notes from user defaults.
    static func savedNotes() -> [Note] {
        let defaults = UserDefaults.standard
        
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                let notes = try jsonDecoder.decode([Note].self, from: savedNotes)
                return notes
            } catch {
                fatalError("Unable to load saved notes.")
            }
        } else {
            return [Note]()
        }
    }
    
    /// Saves the notes array into the user defaults.
    static func save(_ notes: [Note]) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            fatalError("Failed to save notes into user defaults.")
        }
    }
    
}
