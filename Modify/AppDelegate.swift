//
//  AppDelegate.swift
//  Modify
//
//  Created by Daniel on 17/3/28.
//  Copyright © 2017年 Daniel. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    public var mainWindowController:MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        mainWindowController = MainWindowController(windowNibName: "MainWindowController")
        mainWindowController?.window?.center()
        mainWindowController?.window?.makeMain()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

