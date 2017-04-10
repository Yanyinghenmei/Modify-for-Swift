//
//  ArtworkModelsManager.swift
//  Modify
//
//  Created by Daniel on 2017/4/8.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

struct ArtworkImageModel {
    var name:String
    var sourceUrl:URL
    var minImage:NSImage
    
    var width:Double {
        willSet{
            let sourceImage = NSImage.init(contentsOf: sourceUrl)
            minImage = ResourcesManager.creatImage(width: newValue, height: height, image: sourceImage!)
        }
    }
    
    var height:Double {
        willSet{
            let sourceImage = NSImage.init(contentsOf: sourceUrl)
            minImage = ResourcesManager.creatImage(width: width, height: newValue, image: sourceImage!)
        }
    }
    
    var original:Int = 3 {
        willSet{
            if original != newValue {
                
                let sourceImage = NSImage.init(contentsOf: sourceUrl)
                
                let bitImageRep = NSBitmapImageRep.init(data: (sourceImage?.tiffRepresentation)!)!
                let pixwidth = floor(Double(bitImageRep.pixelsWide)/Double(newValue))
                let pixheight = floor(Double(bitImageRep.pixelsHigh)/Double(newValue))
                
                width = pixwidth
                height = pixheight
            }
        }
    }
}

class ArtworkModelsManager {
    public class func creatArtworkImageModel(sourceUrl:URL) -> ArtworkImageModel {
        let sourceImage = NSImage.init(contentsOf: sourceUrl)
        let minImage = ResourcesManager.creatImage(width: Double(CGFloat((sourceImage?.size.width)!/3)), height: Double(CGFloat((sourceImage?.size.height)!/3.00)), image: sourceImage!)
        let range:Range = sourceUrl.lastPathComponent.range(of: ".")!
        let name = sourceUrl.lastPathComponent.substring(to: range.lowerBound)
        
        let bitImageRep = NSBitmapImageRep.init(data: (sourceImage?.tiffRepresentation)!)!
        let width = floor(Double(bitImageRep.pixelsWide)/3.00)
        let height = floor(Double(bitImageRep.pixelsHigh)/3.00)
        
        let model = ArtworkImageModel.init(
            name: name,
            sourceUrl: sourceUrl,
            minImage: minImage,
            width: width,
            height: height,
            original: 3)
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
                    let model = modelArray.object(at: index) as! ArtworkImageModel
                    
                    for index in 1...model.original {
                        var name:String
                        print(index)
                        if index == 1 {
                            name = "\(model.name).png"
                        } else {
                            name = "\(model.name)@\(index)x.png"
                        }
                        let saveUrl = url.appendingPathComponent(name)
                        
                        let sourceImage = NSImage.init(contentsOf: model.sourceUrl)
                        
                        let scale = Double((NSApplication.shared().windows.last?.backingScaleFactor)!) / Double(index)
                        let image = ResourcesManager.creatImage(width: model.width/scale, height:model.height/scale, image: sourceImage!)
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
            }
            exportPanel.close()
        }
        
        return 0
    }
}
