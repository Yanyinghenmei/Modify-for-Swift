//
//  DragDropView.swift
//  Modify
//
//  Created by Daniel on 17/3/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class DragDropView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        //NSColor.init(srgbRed: 241/255.00, green: 241/255.00, blue: 241/255.00, alpha: 1).set()
        NSColor.red.set()
        NSRectFill(dirtyRect)
        
        self.register(forDraggedTypes: [NSFilenamesPboardType])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        let pasteBoard = sender.draggingPasteboard()
        if (pasteBoard.types?.contains(NSFilenamesPboardType))! {
            let list = pasteBoard.propertyList(forType: NSFilenamesPboardType) as! Array<Any>
            let first:String = list.first as! String
            
            if first.hasSuffix("png") ||
                first.hasSuffix("jpg") {
                return .copy
            }
            NSLog("%@", first)
        }
        return .move
    }
    
    // 松开鼠标的时候
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        // 获取拖动数据中的剪贴板
        let pasteBoard = sender.draggingPasteboard()
        if (pasteBoard.types?.contains(NSFilenamesPboardType))! {
            let list = pasteBoard.propertyList(forType: NSFilenamesPboardType) as! Array<Any>
            let first:String = list.first as! String
            
            // 如果是png
            if first.hasSuffix("png") ||
                first.hasSuffix("jpg") {
                let fileUrl = NSURL.fileURL(withPath: first)
                let image = NSImage.init(contentsOf: fileUrl)
                NSLog("%@", first)
            }
            
        }
        // 从剪贴板获取想要的文件链接数组
        
        
        return true
    }
    
}
