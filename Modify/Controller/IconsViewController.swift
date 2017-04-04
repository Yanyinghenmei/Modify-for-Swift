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
    @IBOutlet weak var messageView: NSView!
    @IBOutlet weak var messageLabel: NSTextField!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var typesArr:NSArray?
    var minImageArr:NSMutableArray?
    var numberOfItem:Int?
    
    override var urlArray: Array<URL>? {
        didSet{
            if ((urlArray?.count)! > 1) {
                numberOfItem = 0
                self.tipImageView.isHidden = false
                self.messageView.isHidden = false
                self.messageLabel.stringValue = "Just Drag One Image!"
            } else if (urlArray?.count == 1) {
                numberOfItem = (typesArr==nil) ? 0:Int((typesArr?.count)!)
                self.tipImageView.isHidden = true
                self.messageView.isHidden = true
            } else {
                numberOfItem = 0
                self.tipImageView.isHidden = false
                self.messageView.isHidden = true
            }
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typesArr = ResourcesManager.typesArrayWithPlistName(name: "icontypes")
        
        tipImageView.unregisterDraggedTypes()
        tipImageView.image = ResourcesManager.imageWithName(name: "DropIcon")
        
        self.collectionView.layer?.backgroundColor = NSColor.init(srgbRed: 249/255.00, green: 249/255.00, blue: 249/255.00, alpha: 1).cgColor
        collectionView.register(NSNib.init(nibNamed: "IconsCollectionItem", bundle: nil), forItemWithIdentifier: "Item")
    }
    
    @IBAction func closeMessageView(_ sender: Any) {
        self.messageView.isHidden = true
    }
}

extension IconsViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItem ?? 0
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let dic:NSDictionary = typesArr?[indexPath.item] as! NSDictionary
        
        let item = collectionView.makeItem(withIdentifier: "Item", for: indexPath) as! IconsCollectionItem
        item.nameLabel.stringValue = (dic["name"])! as! String
        item.sizeLabel.stringValue = "\(dic["minsize"] ?? "No Value")x\(dic["minsize"] ?? "No Value")"
        item.imgView?.image = NSImage(contentsOf: (urlArray?.first)!)
        return item
    }
}

extension IconsViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let item = collectionView.item(at: indexPaths.first!)
        item?.isSelected = true
    }
}




