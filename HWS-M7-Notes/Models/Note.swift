//
//  Note.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/27/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

struct Note: Codable {
    var dateLastModified: Date
    var text: String
    
    init(text: String) {
        self.text = text
        dateLastModified = Date()
    }
}
