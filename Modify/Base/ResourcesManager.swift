//
//  ResourcesManager.swift
//  Modify
//
//  Created by Daniel on 2017/4/4.
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
struct ArtworkImageModel {
    var name:String
    var width:Double
    var height:Double
    var sourceUrl:URL
    var minImage:NSImage
    var original:Int = 3
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
    
    // Creat a image
    public class func creatImage(width:Double, height:Double, image:NSImage) -> NSImage {
        
        let newImage:NSImage = NSImage.init(size: CGSize.init(width: width, height: width))
        newImage.lockFocus()
        NSGraphicsContext.saveGraphicsState()
        image.draw(in: NSRect.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(width)))
        
        NSGraphicsContext.restoreGraphicsState()
        newImage.unlockFocus()
        return newImage
    }
    
    // creat a ImageModel
    public class func creatImageModel(info:NSDictionary, imageUrl:URL) -> ImageModel {
        
        let widthStr = info["minsize"] as! String
        let width = Double(widthStr)
        let image = NSImage(contentsOf: imageUrl)
        let newImage = self.creatImage(width: width!, height:width!, image: image!)
        
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
                        let image = self.creatImage(width: width!/scale, height:width!/scale, image: sourceImage!)
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
    
    
/*========================================================*/
    // next function just used at 'Artwork'
    
    public class func creatArtworkImageModel(sourceUrl:URL) -> ArtworkImageModel {
        let sourceImage = NSImage.init(contentsOf: sourceUrl)
        let model = ArtworkImageModel.init(name: sourceUrl.lastPathComponent, width: Double(CGFloat((sourceImage?.size.width)!/3)), height: Double(CGFloat((sourceImage?.size.height)!/3)), sourceUrl: sourceUrl, minImage: sourceImage!, original: 3)
        return model
    }
}

