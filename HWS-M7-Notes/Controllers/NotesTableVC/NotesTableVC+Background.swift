//
//  NotesTableVC+Background.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/27/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

extension NotesTableVC {
    
    func setupBackground() {
        let backgroundImage = UIImage(named: "paperBackground")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
//        tableView.layer.backgroundColor = UIColor.clear.cgColor
    }
}
