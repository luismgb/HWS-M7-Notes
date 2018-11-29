//
//  DetailVC.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/27/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

protocol DetailVCDelegate: class {
    func userChangedTextInNoteTo(text: String, noteIndex: Int, date: Date)
}

class DetailVC: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: DetailVCDelegate!
    
    var notes = [Note]()
    
    var text: String!
    
    var selectedNoteIndex: Int!

    // MARK: - IBOutlets
    
    @IBOutlet var textView: UITextView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.text = text
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.adjustsFontForContentSizeCategory = true
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil) // swiftlint:disable:this line_length
        
        notificationCenter.addObserver(self, selector: #selector(showDoneBarButton), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(hideDoneBarButton), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.setToolbarHidden(true, animated: true)
        
        populateNotesArrayWithSavedNotes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: true)
        
        saveNotes()
        
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
    
}
