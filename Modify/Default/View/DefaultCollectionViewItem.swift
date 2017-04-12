//
//  DefaultCollectionViewItem.swift
//  Modify
//
//  Created by Daniel on 2017/4/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class DefaultCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.unregisterDraggedTypes()
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
    }
}
