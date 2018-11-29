//
//  DetailVC.swift
//  HWS-M7-Notes
//
//  Created by Luis M Gonzalez on 11/27/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var text: String!

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }

}
