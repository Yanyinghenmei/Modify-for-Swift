//
//  IconsViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class IconsViewController: ContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        // Do view setup here.
    }
    
    override func viewDidLayout() {
        self.view.layer?.backgroundColor = NSColor.red.cgColor
    }
}
