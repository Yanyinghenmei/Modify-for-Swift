//
//  IconsViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class IconsViewController: ContentViewController {
    
    @IBOutlet weak var tipImageView: NSImageView!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var typesArr:NSArray?
    var modelArr:NSMutableArray?
    var numberOfItem:Int?
    
    override var urlArray: Array<URL>? {
        didSet{
            if ((urlArray?.count)! > 0) {
                self.tipImageView.isHidden = true
                numberOfItem = (typesArr==nil) ? 0:Int((typesArr?.count)!)
                
                DispatchQueue.global().async {
                    self.modelArr = NSMutableArray.init()
                    for url:URL in self.urlArray! {
                        
                        let subImageArr:NSMutableArray = NSMutableArray.init()
                        for dic in self.typesArr! {
                            let model = ResourcesManager.creatImageModel(info: dic as! NSDictionary, imageUrl: url)
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
                self.tipImageView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typesArr = ResourcesManager.typesArrayWithPlistName(name: "icontypes")
        
        tipImageView.unregisterDraggedTypes()
        tipImageView.image = ResourcesManager.imageWithName(name: "DropIcon")
        
        self.collectionView.layer?.backgroundColor = NSColor.init(srgbRed: 249/255.00, green: 249/255.00, blue: 249/255.00, alpha: 1).cgColor
        collectionView.register(NSNib.init(nibNamed: "IconsCollectionItem", bundle: nil), forItemWithIdentifier: "Item")
        collectionView.register(NSNib.init(nibNamed: "IconsCollectionHeader", bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withIdentifier: "Header")
    }
}

extension IconsViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return (urlArray == nil) ? 0 : (urlArray?.count)!
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItem ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        if kind == "UICollectionElementKindSectionHeader" {
            let header:IconsCollectionHeader = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: "Header", for: indexPath) as! IconsCollectionHeader
            header.section = indexPath.section
            header.exportHandle = {section in
                // exportImage
                let subArr:NSArray = self.modelArr?.object(at: indexPath.section) as! NSArray
                let _ = ResourcesManager.exportImages(modelArray: subArr)
            }
            
            return header;
        } else {
            return NSView.init()
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let subArray:NSArray = modelArr?.object(at: indexPath.section) as! NSArray
        let model:ImageModel = subArray.object(at: indexPath.item) as! ImageModel
        
        let item = collectionView.makeItem(withIdentifier: "Item", for: indexPath) as! IconsCollectionItem
        item.nameLabel.stringValue = model.name
        item.sizeLabel.stringValue = "\(model.minsize)x\(model.minsize)"
        item.imgView.image = model.minImage
        return item
    }
}

extension IconsViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            let item = collectionView.item(at: indexPath)
            item?.isSelected = true
        }

    }
}




