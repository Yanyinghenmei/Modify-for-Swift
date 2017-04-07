//
//  IconsCollectionItem.swift
//  Modify
//
//  Created by Daniel on 2017/4/3.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class IconsCollectionItem: NSCollectionViewItem {

    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var imgView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.unregisterDraggedTypes()
        // Do view setup here.
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                view.layer?.borderColor = NSColor.keyboardFocusIndicatorColor.cgColor
            } else {
                view.layer?.borderColor = NSColor.clear.cgColor
            }
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        view.layer?.cornerRadius = 10
        view.layer?.masksToBounds = true
        view.layer?.borderWidth = 1.00
        view.layer?.borderColor = NSColor.clear.cgColor
        
        imgView.layer?.cornerRadius = imgView.bounds.size.width/5.700
    }
    
    
}
