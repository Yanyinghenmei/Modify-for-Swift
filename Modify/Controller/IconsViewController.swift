//
//  IconsViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class IconsViewController: ContentViewController {
    
    @IBOutlet weak var messageView: NSView!
    @IBOutlet weak var messageLabel: NSTextField!
    
    override var urlArray: Array<URL>? {
        didSet{
            if ((urlArray?.count)! > 1) {
                self.messageView.isHidden = false
                self.messageLabel.stringValue = "Just Drag One Image!"
            } else {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeMessageView(_ sender: Any) {
        self.messageView.isHidden = true
    }
}
