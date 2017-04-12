//
//  DefaultModelsManager.swift
//  Modify
//
//  Created by Daniel on 2017/4/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

struct DefaultModel {
    var name:String
    var width:Int
    var height:Int
    var platform:String
    var image:NSImage
    var isPortrait:Bool
}

class DefaultModelsManager {
    public class func creatImageModel(info:NSDictionary, imageUrl:URL) -> DefaultModel {
        let width:Int = Int(info["width"] as! String)!
        let height:Int = Int(info["height"] as! String)!
        
        let image = NSImage(contentsOf: imageUrl)
        let newImage = ResourcesManager.clipImage(size: CGSize.init(width: CGFloat(width), height: CGFloat(height)), image: image!)
        
        let model = DefaultModel.init(name: info["name"] as! String, width: width, height: height, platform: info["platform"] as! String, image: newImage, isPortrait: info["isPortrait"] as! Bool)
        
        return model
    }
    
    // export images
    public class func exportImages(modelArray:NSArray) -> Int {
        let exportPanel = NSOpenPanel.init()
        exportPanel.prompt = "Choose"
        exportPanel.message = "Choose a location for the icon files"
        exportPanel.canChooseFiles = false
        exportPanel.canChooseDirectories = true
        exportPanel.allowsMultipleSelection = false
        exportPanel.canCreateDirectories = true
        exportPanel.begin { (result) in
            if result == NSFileHandlingPanelOKButton {
                let url = exportPanel.url!
                
                for index in 0..<modelArray.count {
                    let model = modelArray.object(at: index) as! DefaultModel
                    
                    let imageName = "\(model.name).png"
                    let saveUrl = url.appendingPathComponent(imageName)
                    let scale = Double((NSApplication.shared().windows.last?.backingScaleFactor)!)
                    
                    var width:Double?
                    var height:Double?
                    if model.isPortrait == true {
                        width = Double(model.width)
                        height = Double(model.height)
                    } else {
                        width = Double(model.height)
                        height = Double(model.width)
                    }
                    
                    let image:NSImage = ResourcesManager.creatImage(width: width!/scale, height: height!/scale, image: model.image)
                    
                    let imageData = image.tiffRepresentation
                    
                    let bitRep:NSBitmapImageRep = NSBitmapImageRep.init(data: imageData!)!
                    
                    let resultData = bitRep.representation(using: NSBitmapImageFileType.PNG, properties: Dictionary.init())
                    
                    do {
                        try resultData?.write(to: saveUrl)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                }
            }
            exportPanel.close()
        }
        
        return 0
    }
}
