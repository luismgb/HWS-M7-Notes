//
//  NotesTableVC+DetailVCDelegate.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/28/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import Foundation

extension NotesTableVC: DetailVCDelegate {
    
    // MARK: - DetailVC Delegate Methods
    
    func userChangedTextInNoteTo(text: String, noteIndex: Int, date: Date) {
        notes[noteIndex].text = text
        notes[noteIndex].dateLastModified = date
    }
    
}
