//
//  CustomScrollerViewController.swift
//  Scrollers
//
//  Created by John Brayton on 5/13/23.
//

import AppKit
import WebKit

class CustomScrollerViewController : NSViewController {
    
    var yellowBackgroundView: NSView!
    var webView: WKWebView!
    var customScroller: CustomScroller!
    var userContentController: WKUserContentController!
    weak var scrollingMessageHandler: ScrollingMessageHandler?
    
    // Use this to determine whether the user is currently scrolling by dragging the
    // scroller. If the user is currently scrolling with the scroller when we get a message
    // from the webView that the scroll position change, do not update the scroller based
    // on the webView change. This should prevent an infinite loop of the scroller updating the
    // webView and the webView updating the scroller. If usingScrollKnobCount is greater than 1,
    // this view controller is reacting to the user moving the scroller.
    var usingScrollKnobCount = 0
    
    // The scroll position, view height, and content height.
    var scrollState: ScrollState?
    
    override func viewDidLoad() {
        
        // This view has the same background color as the webView body.
        // This appears to have no visible effect, but helps demonstrate
        // that putting solid background behind the scrollable webview does
        // not help.
        self.yellowBackgroundView = YellowBackgroundView(frame: self.view.bounds)
        self.view.addSubview(yellowBackgroundView)

        let scrollingMessageHandler = ScrollingMessageHandler(customScrollerViewController: self)
        self.userContentController = WKUserContentController()
        self.userContentController.add(scrollingMessageHandler, name: "callbackHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = self.userContentController
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        self.webView.autoresizingMask = [.width, .height]
        self.view.addSubview(self.webView)
        let fileUrl = Bundle.main.url(forResource: "customscroller", withExtension: "html")!
        let data = try! Data(contentsOf: fileUrl)
        let html = String(data: data, encoding: .utf8)!
        self.webView.loadHTMLString(html, baseURL: nil)
        
        let scrollerWidth: CGFloat = 15.0
        self.customScroller = CustomScroller(customScrollerViewController: self, frame: NSRect(x: self.view.bounds.width - scrollerWidth, y: 0.0, width: scrollerWidth, height: self.view.bounds.size.height))
        self.customScroller.autoresizingMask = [.height, .minXMargin]
        self.customScroller.isEnabled = true
        self.view.addSubview(self.customScroller)
    }
    
    func updateScrollState( scrollState: ScrollState) {
        guard self.usingScrollKnobCount == 0 else {
            return
        }
        if scrollState.viewHeight >= scrollState.contentHeight {
            self.customScroller.isHidden = true
        } else {
            self.customScroller.doubleValue = scrollState.position / (scrollState.contentHeight - scrollState.viewHeight)
            self.customScroller.knobProportion = scrollState.viewHeight / scrollState.contentHeight
            self.customScroller.isHidden = false
            self.customScroller.setNeedsDisplay(self.customScroller.bounds)
        }
        self.scrollState = scrollState
    }
    
    // When the user moves the scroller, tell the webview to scroll.
    func userMovedScroller() {
        Task { [weak self] in
            if let self, let scrollState = self.scrollState {
                self.usingScrollKnobCount = self.usingScrollKnobCount + 1
                let position = self.customScroller.doubleValue * (scrollState.contentHeight - scrollState.viewHeight)
                try await self.webView.evaluateJavaScript("MyAppScrollTo(\(position));")
                self.usingScrollKnobCount = self.usingScrollKnobCount - 1
            }
        }

    }

}
