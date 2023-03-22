//
//  BaseButton.swift
//  Modify
//
//  Created by Daniel on 17/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class BaseButton: NSButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.image = #imageLiteral(resourceName: "btn_normal")
        (self.cell as! NSButtonCell).highlightsBy = NSCell.StyleMask(rawValue: 0)
    }
    
    public
    var isSelect:Bool = false {
        willSet {
            if newValue {
                self.image = #imageLiteral(resourceName: "btn_select")
            } else {
                self.image = #imageLiteral(resourceName: "btn_normal")
            }
        }
    }
    
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer() {
        self.layer?.backgroundColor = NSColor.clear.cgColor
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
}
