//
//  MessageView.swift
//  Modify
//
//  Created by Daniel on 17/3/30.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class MessageView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.init(srgbRed: 253/255.00, green: 246/255.00, blue: 228/255.00, alpha: 1).set()
        NSRectFill(dirtyRect)
    }
}
