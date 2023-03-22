//
//  DefaultViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class DefaultViewController: ContentViewController {
    @IBOutlet weak var tipImgView: NSImageView!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var typesArr:NSArray?
    var modelArr:NSMutableArray?
    var numberOfItem:Int?
    
    override var urlArray: Array<URL>? {
        didSet{
            if ((urlArray?.count)! > 0) {
                self.tipImgView.isHidden = true
                numberOfItem = (typesArr==nil) ? 0:Int((typesArr?.count)!)
                
                DispatchQueue.global().async {
                    self.modelArr = NSMutableArray.init()
                    for url:URL in self.urlArray! {
                        
                        let subImageArr:NSMutableArray = NSMutableArray.init()
                        for dic in self.typesArr! {
                            let model = DefaultModelsManager.createImageModel(info: dic as! NSDictionary, imageUrl: url)
                            subImageArr.add(model)
                        }
                        self.modelArr?.add(subImageArr)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            } else {
                numberOfItem = 0
                self.tipImgView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tipImgView.unregisterDraggedTypes()
        typesArr = ResourcesManager.typesArrayWithPlistName(name: "defaulttypes")
        tipImgView.image = ResourcesManager.imageWithName(name: "DropDefault")
    }
    
    override func viewDidLayout() {
        collectionView.layer?.backgroundColor = NSColor.init(srgbRed: 249/255.00, green: 249/255.00, blue: 249/255.00, alpha: 1).cgColor
        
        collectionView.register(DefaultCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "Default"))
        collectionView.register(NSNib.init(nibNamed: "DefaultCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "DefaultHeader"))
    }
}


extension DefaultViewController: NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return (urlArray == nil) ? 0 : (urlArray?.count)!
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItem ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        if kind == "UICollectionElementKindSectionHeader" {
            let header:DefaultCollectionViewHeader = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "DefaultHeader"), for: indexPath) as! DefaultCollectionViewHeader
            
            let subArr:NSArray = self.modelArr?.object(at: indexPath.section) as! NSArray
            let firstModel = subArr.firstObject as! DefaultModel
            header.isPortraitBtn.selectItem(withTag: firstModel.isPortrait==true ? 0 : 1)
            
            header.section = indexPath.section
            header.isPortraitHandle = {tag in
                let sourceUrl = self.urlArray?[indexPath.section]
                let tempArr:NSMutableArray = NSMutableArray.init()
                for index in 0..<subArr.count {
                    var model = subArr.object(at: index) as! DefaultModel
                    model.isPortrait = (tag==0) ? true : false
                    
                    if model.isPortrait == true {
                        model.image = ResourcesManager.clipImage(size: CGSize.init(width: model.width, height: model.height), image: NSImage.init(contentsOf: sourceUrl!)!)
                    } else {
                        model.image = ResourcesManager.clipImage(size: CGSize.init(width: model.height, height: model.width), image: NSImage.init(contentsOf: sourceUrl!)!)
                    }
                    
                    tempArr.add(model)
                }
                
                self.modelArr?.replaceObject(at: indexPath.section, with: tempArr)
                self.collectionView.reloadData()
            }
            header.exportHandle = {section in
                // exportImage
                let subArr:NSArray = self.modelArr?.object(at: indexPath.section) as! NSArray
                let _ = DefaultModelsManager.exportImages(modelArray: subArr)
            }
            
            return header;
        } else {
            return NSView.init()
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let subArray:NSArray = modelArr?.object(at: indexPath.section) as! NSArray
        let model:DefaultModel = subArray.object(at: indexPath.item) as! DefaultModel
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "Default"), for: indexPath) as! DefaultCollectionViewItem
        item.nameLabel.stringValue = model.name
        item.sizeLabel.stringValue = "\(model.width)x\(model.height)"
        item.imgView.image = model.image
        
        return item
    }
}

extension DefaultViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            let item = collectionView.item(at: indexPath)
            item?.isSelected = true
        }
    }
}


