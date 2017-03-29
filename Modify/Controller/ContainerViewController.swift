//
//  ContainerViewController.swift
//  Modify
//
//  Created by Daniel on 2017/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

class ContainerViewController: NSViewController {

    public var containerView:NSView?
    var currentVC:NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconVC = IconsViewController(nibName: "IconsViewController", bundle: nil)
        let artworkVC = ArtworkViewController(nibName: "ArtworkViewController", bundle: nil)
        let defaultVC = DefaultViewController(nibName: "DefaultViewController", bundle: nil)
        
        self.addChildViewController(iconVC!)
        self.addChildViewController(artworkVC!)
        self.addChildViewController(defaultVC!)
        
        self.currentVC = iconVC
        self.view.addSubview((iconVC?.view)!)
        
        self.view.addObserver(self, forKeyPath: "frame", options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if change?.count != 0 {
            let frame:NSRect = change![NSKeyValueChangeKey.init(rawValue: "new")] as! NSRect
            self.currentVC?.view.frame = NSRect.init(origin: .zero, size: frame.size)
        }
    }
    
    public func setCurrentIndex(index num:NSInteger, block:@escaping ()->Void) {
        if currentVC! != self.childViewControllers[num] {
            self.transition(from: currentVC!, to: self.childViewControllers[num], options: [NSViewControllerTransitionOptions.init(rawValue: 0)], completionHandler: {
                self.currentVC = self.childViewControllers[num]
                block()
            })
        }
    }
}
