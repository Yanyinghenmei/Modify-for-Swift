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
//        let constraintTop = NSLayoutConstraint.init(item: (iconVC?.view)!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
//        let constraintButtom = NSLayoutConstraint.init(item: (iconVC?.view)!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
//        
//        self.view.addConstraint(constraintTop)
//        self.view.addConstraint(constraintButtom)
    }
    
    override func preferredContentSizeDidChange(for viewController: NSViewController) {
        
    }
    
    public func transtionViewController() {
        
    }
}
