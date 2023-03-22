//
//  ArtworkCollectionItem.swift
//  Modify
//
//  Created by Daniel on 2017/4/7.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

enum ArtworkType {
    case ArtworkTypeDouble
    case ArtworkTypeTreble
}

class ArtworkCollectionItem: NSCollectionViewItem {

    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var widthLabel: NSTextField!
    @IBOutlet weak var heightLabel: NSTextField!
    @IBOutlet weak var originalButton: NSPopUpButton!
    
    public var nameChangeBlock:((_ name:String)->Void)?
    public var widthChangeBlock:((_ width:Double)->Void)?
    public var heightChangeBlock:((_ height:Double)->Void)?
    public var originalChangeBlock:((_ type:ArtworkType)->Void)?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.unregisterDraggedTypes()
        let formatter = MyNumberFormatter.init()
        formatter.numberStyle = .none
        widthLabel.formatter = formatter
        heightLabel.formatter = formatter
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
    
    @IBAction func nameChange(_ sender: NSTextField) {
        if nameChangeBlock != nil {
            nameChangeBlock!(sender.stringValue)
        }
    }
    
    @IBAction func originalChnage(_ sender: NSPopUpButton) {
        print(sender.selectedTag())
        if originalChangeBlock != nil {
            if (sender.selectedTag() == 0) {
                originalChangeBlock!(ArtworkType.ArtworkTypeDouble)
            } else {
                originalChangeBlock!(ArtworkType.ArtworkTypeTreble)
            }
        }
    }
    
    @IBAction func widthChange(_ sender: NSTextField) {
        if widthChangeBlock != nil {
            let formatter = heightLabel.formatter as! NumberFormatter
            let number = formatter.number(from: sender.stringValue)
            widthChangeBlock!((number?.doubleValue)!)
        }
    }
    
    @IBAction func heightChange(_ sender: NSTextField) {
        if heightChangeBlock != nil {
            let formatter = heightLabel.formatter as! NumberFormatter
            let number = formatter.number(from: sender.stringValue)
            heightChangeBlock!((number?.doubleValue)!)
        }
    }
    
}

class MyNumberFormatter: NumberFormatter {
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        let scanner = Scanner.init(string: partialString)
        var value:Int = 0
        if !(scanner.scanInt(&value) && scanner.isAtEnd) {
//            NSBeep()
            __NSBeep()
            return false
        }
        
        return true
    }
}
