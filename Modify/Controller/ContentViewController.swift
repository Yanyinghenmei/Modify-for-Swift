//
//  ContentViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class ContentViewController: NSViewController {
    
    public func tabBtnClick(btn:NSButton) {
        print(btn.tag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}
