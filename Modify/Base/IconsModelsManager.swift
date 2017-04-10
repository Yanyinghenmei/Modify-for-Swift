//
//  IconsModelsManager.swift
//  Modify
//
//  Created by Daniel on 2017/4/8.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

struct ImageModel {
    var name:String
    var minsize:Double
    var sizes:Array<String>
    var sourceUrl:URL
    var minImage:NSImage
}

class IconsModelsManager {
    
    // creat a ImageModel
    public class func creatImageModel(info:NSDictionary, imageUrl:URL) -> ImageModel {
        
        let widthStr = info["minsize"] as! String
        let width = Double(widthStr)
        let image = NSImage(contentsOf: imageUrl)
        let newImage = ResourcesManager.creatImage(width: width!, height:width!, image: image!)
        
        let model = ImageModel.init(name: info["name"] as! String, minsize: width!, sizes: info["sizes"] as! Array<String>, sourceUrl: imageUrl, minImage: newImage)
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
                    let model = modelArray.object(at: index) as! ImageModel
                    
                    for sizeIndex in 0..<model.sizes.count {
                        let widthStr = model.sizes[sizeIndex]
                        let width = Double(widthStr)
                        var imageName:String?
                        if (width == model.minsize) {
                            imageName = "\(model.name).png"
                        } else {
                            let proportion = Int(width!/model.minsize)
                            imageName = "\(model.name)@\(proportion)x.png"
                        }
                        
                        // if it's iTunesArtWork
                        if model.name == "iTunesArtwork" {
                            imageName?.removeSubrange((imageName?.index((imageName?.endIndex)!, offsetBy: -4))!..<(imageName?.endIndex)!)
                        }
                        
                        let saveUrl = url.appendingPathComponent(imageName!)
                        
                        let sourceImage = NSImage.init(contentsOf: model.sourceUrl)
                        
                        let scale = Double((NSApplication.shared().windows.last?.backingScaleFactor)!)
                        let image = ResourcesManager.creatImage(width: width!/scale, height:width!/scale, image: sourceImage!)
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
