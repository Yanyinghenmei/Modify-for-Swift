//
//  DragDropView.swift
//  Modify
//
//  Created by Daniel on 17/3/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class DragDropView: NSView {
    
    weak var delegate:DragDropDelegate?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.init(srgbRed: 249/255.00, green: 249/255.00, blue: 249/255.00, alpha: 1).set()
        NSRectFill(dirtyRect)
        
        self.register(forDraggedTypes: [NSFilenamesPboardType])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        let pasteBoard = sender.draggingPasteboard()
        if (pasteBoard.types?.contains(NSFilenamesPboardType))! {
            let list = pasteBoard.propertyList(forType: NSFilenamesPboardType) as! Array<Any>
            sender.numberOfValidItemsForDrop = list.count
            
            for index in 0..<list.count {
                let path = list[index] as! String
                if path.hasSuffix("png") ||
                    path.hasSuffix("jpg") ||
                    path.hasSuffix("jpeg") {
                    return .copy
                }
            }
        }
        return .move 
    }
    
    // 松开鼠标的时候
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        // 获取拖动数据中的剪贴板
        let pasteBoard = sender.draggingPasteboard()
        if (pasteBoard.types?.contains(NSFilenamesPboardType))! {
            let list = pasteBoard.propertyList(forType: NSFilenamesPboardType) as! Array<Any>
            
            var urlArr:Array<URL> = []
            for index in 0..<list.count {
                let path = list[index] as! String
                
                if path.hasSuffix("png") ||
                    path.hasSuffix("jpg") ||
                    path.hasSuffix("jpeg") {
                    let imageUrl = URL.init(fileURLWithPath: path)
                    urlArr.append(imageUrl)
                }
            }
            
            self.delegate?.prepareForDargUrlArray(urlArray: urlArr)
        }
        
        return true
    }
    
}

protocol DragDropDelegate: class {
    func prepareForDargUrlArray(urlArray:Array<URL>)
}

