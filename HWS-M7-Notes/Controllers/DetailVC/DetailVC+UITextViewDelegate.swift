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
    
    func textViewDidChange(_ textView: UITextView) {
        text = textView.text
        delegate.userChangedTextInNoteTo(text: text, noteIndex: selectedNoteIndex, date: Date())
    }
    
}
