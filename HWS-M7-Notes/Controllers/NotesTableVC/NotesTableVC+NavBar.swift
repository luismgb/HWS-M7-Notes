//
//  NotesTableVC+NavBar.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/28/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

extension NotesTableVC {
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 202.0/255.0, green: 163.0/255.0, blue: 0, alpha: 1)
    }
    
}
