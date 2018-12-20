//
//  AppDelegate.swift
//  Modify
//
//  Created by Daniel on 17/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

// Human Interface Guidelines
// https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    public var mainWindowController:MainWindowController?
    public var scale:CGFloat?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        mainWindowController = MainWindowController(windowNibName: "MainWindowController")
        mainWindowController?.window?.center()
        mainWindowController?.window?.makeMain()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

