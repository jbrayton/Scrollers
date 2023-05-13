//
//  YellowBackgroundView.swift
//  Scrollers
//
//  Created by John Brayton on 5/13/23.
//

import AppKit

class YellowBackgroundView : NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        let color = NSColor(red: 0.917000, green: 0.809000, blue: 0.582000, alpha: 1.000000)
        color.set()
        NSBezierPath(rect: self.bounds).fill()
    }
    
}
