//
//  DefaultCollectionViewHeader.swift
//  Modify
//
//  Created by Daniel on 2017/4/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class DefaultCollectionViewHeader: NSView {

    @IBOutlet weak var isPortraitBtn: NSPopUpButton!
    public var exportHandle:((_ section:Int)->Void)?
    public var isPortraitHandle:((_ selectTag:Int)->Void)?
    public var section:Int?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.white.set()
        NSRectFill(dirtyRect)
    }
    
    @IBAction func isPortraitChange(_ sender: NSPopUpButton) {
        if (isPortraitHandle != nil) {
            isPortraitHandle!(sender.selectedTag())
        }
    }
    
    @IBAction func exportClick(_ sender: NSButton) {
        if (exportHandle != nil &&
            section != nil) {
            exportHandle!(section!)
        }
    }
}
