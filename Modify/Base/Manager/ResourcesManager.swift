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
    
    // Create a image
    public class func createImage(width:Double, height:Double, image:NSImage) -> NSImage {
        
        let newImage:NSImage = NSImage.init(size: CGSize.init(width: width, height: height))
        newImage.lockFocus()
        NSGraphicsContext.saveGraphicsState()
        image.draw(in: NSRect.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        
        NSGraphicsContext.restoreGraphicsState()
        newImage.unlockFocus()
        return newImage
    }
    
    public class func clipImage(size:CGSize, image:NSImage) -> NSImage {
        
        let fromRect:NSRect?
        
        // image的宽比较大 或者image的高比价小
        
        if image.size.width/image.size.height >= size.width/size.height {
            let width = image.size.height * (size.width/size.height)
            fromRect = NSRect.init(x: (image.size.width-width)/2, y: 0, width: width, height: image.size.height)
        } else {
            let height = image.size.width * (size.height/size.width)
            fromRect = NSRect.init(x: 0, y: (image.size.height-height)/2, width: image.size.width, height: height)
        }
        
        let newImage:NSImage = NSImage.init(size: size)
        newImage.lockFocus()
        NSGraphicsContext.saveGraphicsState()
        image.draw(in: NSRect.init(origin: .zero, size: size), from: fromRect!, operation: .copy, fraction: 1)
        
        NSGraphicsContext.restoreGraphicsState()
        newImage.unlockFocus()
        
        return newImage
    }
    
}

