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


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.startingPointWindowController = (NSStoryboard(name: "StartingPointWindow", bundle: nil).instantiateController(withIdentifier: "StartingPointWindow") as! NSWindowController)
        self.startingPointWindowController.showWindow(nil)

        
        
    }

}
