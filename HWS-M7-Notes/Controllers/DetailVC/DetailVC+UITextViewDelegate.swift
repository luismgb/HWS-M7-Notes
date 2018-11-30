//
//  DetailVC+UITextViewDelegate.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/28/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

extension DetailVC: UITextViewDelegate {
    
    // MARK: - Text View Delegate Methods
    
    /// Saves the notes array everytime the text of a note is modified.
    func textViewDidChange(_ textView: UITextView) {
        notes[selectedNoteIndex].text = textView.text
        notes[selectedNoteIndex].dateLastModified = Date()
        Utilities.save(notes)
    }
    
}
