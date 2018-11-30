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
    
    // MARK: - Helper Methods
    
    static func backgroundImageView() -> UIImageView {
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "paperBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        return backgroundImageView
    }
    
    /// Returns a DateFormatter that dispays for example, November 27th, 2019 as
    /// 11/27/19.
    static func customDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
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
