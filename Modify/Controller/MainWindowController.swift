//
//  MainWindowController.swift
//  Modify
//
//  Created by Daniel on 17/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var leftView: NSView!
    @IBOutlet weak var iconBtn: BaseButton!
    @IBOutlet weak var artworkBtn: BaseButton!
    @IBOutlet weak var defaultBtn: BaseButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.title = "Modift"
        
        self.window?.minSize = CGSize.init(width: 600, height: 550)
        iconBtn.isSelect = true
        
        self.leftView.layer?.backgroundColor = NSColor.init(srgbRed: 56/255.0, green: 56/255.0, blue: 56/255.0, alpha: 1).cgColor
        
        setColor(btn: iconBtn, color: NSColor.white)
        setColor(btn: artworkBtn, color: NSColor.white)
        setColor(btn: defaultBtn, color: NSColor.white)
        
    }
    
    func setColor(btn:NSButton, color:NSColor) {
        let mutableAttrStr = NSMutableAttributedString.init(attributedString: btn.attributedTitle)
        
        mutableAttrStr.addAttributes([NSForegroundColorAttributeName:color], range: NSRange.init(location: 0, length: btn.attributedTitle.length))
        btn.attributedTitle = mutableAttrStr
    }
    
    @IBAction func btnClick(_ sender: BaseButton) {
        self.iconBtn.isSelect = false
        self.artworkBtn.isSelect = false
        self.defaultBtn.isSelect = false
        
        sender.isSelect = true
    }
    
}







