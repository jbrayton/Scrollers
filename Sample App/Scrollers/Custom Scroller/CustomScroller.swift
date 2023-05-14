//
//  CustomScroller.swift
//  Scrollers
//
//  Created by John Brayton on 5/13/23.
//

import AppKit

class CustomScroller : NSScroller {
    
    weak var customScrollerViewController: CustomScrollerViewController?
    
    // Use `tracking` to determine whether the user is currently dragging the scroller.
    // If true, the view controller needs to update the webView. If false, the view controller
    // probably changed `doubleValue` in response to the webView being scrolled via other
    // means.
    var tracking: Bool = false
    
    init( customScrollerViewController: CustomScrollerViewController, frame: NSRect ) {
        super.init(frame: frame)
        self.customScrollerViewController = customScrollerViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var doubleValue: Double {
        didSet {
            if tracking {
                self.customScrollerViewController?.userMovedScroller()
            }
        }
    }
    
    override func trackKnob(with event: NSEvent) {
        self.tracking = true
        super.trackKnob(with: event)
        self.tracking = false
    }
    
    override class func scrollerWidth(for controlSize: NSControl.ControlSize, scrollerStyle: NSScroller.Style) -> CGFloat {
        let result = super.scrollerWidth(for: controlSize, scrollerStyle: scrollerStyle)
        if scrollerStyle == .legacy {
            return result - 4.0
        } else {
            return result
        }
    }
    
    override func drawKnobSlot(in slotRect: NSRect, highlight flag: Bool) {
        super.drawKnobSlot(in: slotRect, highlight: flag)
        NSColor(red: 0.917000, green: 0.809000, blue: 0.582000, alpha: 1.000000).set()
        NSBezierPath(rect: slotRect).fill()
    }
    
}
