//
//  ResourcesManager.swift
//  Modify
//
//  Created by Daniel on 2017/4/4.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

enum PlistType {
    case Icons
    case ArtWork
    case Default
}

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
}
