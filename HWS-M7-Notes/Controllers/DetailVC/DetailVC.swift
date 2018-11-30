//
//  DetailVC.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/27/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - Properties
    
    var notes = [Note]()
    
    var selectedNoteIndex: Int!

    // MARK: - IBOutlets
    
    @IBOutlet var textView: UITextView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = Utilities.savedNotes()
        
        // If the user navigated to the DetailVC to create a new note, the
        // selectedNoteIndex will be equal to the index of the last item in
        // notes plus one (notes.endIndex). The selectedNoteIndex should be set
        // when performing the segue to a DetailVC.
        if notes.endIndex == selectedNoteIndex {
            createEmptyNote()
        }
        
        setupTextView()
        setupKeyboardNotificationObservers()
        
        view.insertSubview(Utilities.backgroundImageView(), at: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: true)
        
        // Remove note if it is empty to avoid saving empty notes.
        if notes[selectedNoteIndex].text == "" {
            notes.remove(at: selectedNoteIndex)
        }
        
        Utilities.save(notes)
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Keyboard Handling Methods
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue // swiftlint:disable:this force_cast
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Done Button Methods
    
    @objc func showDoneBarButton() {
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideKeyboard))
        navigationItem.setRightBarButton(doneBarButton, animated: true)
    }
    
    @objc func hideDoneBarButton() {
        navigationItem.setRightBarButton(nil, animated: true)
    }
    
    // MARK: - Helper Methods
    
    /// Instantiates a new empty note and saves it.
    func createEmptyNote() {
        let newNote = Note(text: "")
        notes.append(newNote)
        Utilities.save(notes)
    }
    
    /// Sets up the textView properties.
    func setupTextView() {
        textView.text = notes[selectedNoteIndex].text
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.adjustsFontForContentSizeCategory = true
        textView.backgroundColor = UIColor.clear
    }
    
    // Sets up the observers for the keyboard lifecyle notifications.
    func setupKeyboardNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        
        // Used for adjusting the textView so the text doesn't get hidden behind
        // the keyboard.
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil) // swiftlint:disable:this line_length
        
        // Used to show/hide the Done bar button that the user can use to hide
        // the keyboard.
        notificationCenter.addObserver(self, selector: #selector(showDoneBarButton), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(hideDoneBarButton), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
