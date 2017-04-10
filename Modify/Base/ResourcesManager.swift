//
//  ResourcesManager.swift
//  Modify
//
//  Created by Daniel on 2017/4/4.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa


class ResourcesManager {
    
    public class func imageWithName(name:String) -> NSImage {
        let bundlePath = Bundle.main.path(forResource: "Images", ofType: "bundle")
        let bundle = Bundle.init(path: bundlePath!)
        let image = bundle?.image(forResource: name)
        return image ?? NSImage.init()
    }
    
    public class func typesArrayWithPlistName(name:String) -> NSArray{
        let path:String = Bundle.main.path(forResource: name, ofType: "plist")!
        let array = NSArray(contentsOfFile: path)
        return array ?? NSArray()
    }
    
    // Creat a image
    public class func creatImage(width:Double, height:Double, image:NSImage) -> NSImage {
        
        let newImage:NSImage = NSImage.init(size: CGSize.init(width: width, height: height))
        newImage.lockFocus()
        NSGraphicsContext.saveGraphicsState()
        image.draw(in: NSRect.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        
        NSGraphicsContext.restoreGraphicsState()
        newImage.unlockFocus()
        return newImage
    }
    
}

