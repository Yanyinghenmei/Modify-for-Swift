//
//  IconsCollectionHeader.swift
//  Modify
//
//  Created by Daniel on 2017/4/5.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class IconsCollectionHeader: NSView {

    public var exportHandle:((_ section:Int)->Void)?
    public var section:Int?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.white.set()
//        NSRectFill(dirtyRect)
        __NSRectFill(dirtyRect)
    }
    
    @IBAction func exportClick(_ sender: NSButton) {
        if (exportHandle != nil &&
            section != nil) {
            exportHandle!(section!)
        }
    }
}
