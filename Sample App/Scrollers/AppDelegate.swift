//
//  AppDelegate.swift
//  Scrollers
//
//  Created by John Brayton on 5/13/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var startingPointWindowController: NSWindowController!
    var cssScrollerWindowController: NSWindowController!
    var customScrollerWindowController: NSWindowController!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        var cascadePoint = NSPoint.zero

        self.startingPointWindowController = (NSStoryboard(name: "StartingPointWindow", bundle: nil).instantiateController(withIdentifier: "StartingPointWindow") as! NSWindowController)
        self.startingPointWindowController.showWindow(nil)
        cascadePoint = self.startingPointWindowController.window!.cascadeTopLeft(from: cascadePoint)

        self.cssScrollerWindowController = (NSStoryboard(name: "CSSScrollerWindow", bundle: nil).instantiateController(withIdentifier: "CSSScrollerWindow") as! NSWindowController)
        self.cssScrollerWindowController.showWindow(nil)
        cascadePoint = self.cssScrollerWindowController.window!.cascadeTopLeft(from: cascadePoint)

        self.customScrollerWindowController = (NSStoryboard(name: "CustomScrollerWindow", bundle: nil).instantiateController(withIdentifier: "CustomScrollerWindow") as! NSWindowController)
        self.customScrollerWindowController.showWindow(nil)
        cascadePoint = self.customScrollerWindowController.window!.cascadeTopLeft(from: cascadePoint)
    }

}

