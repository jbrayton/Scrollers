//
//  StartingPointViewController.swift
//  Scrollers
//
//  Created by John Brayton on 5/13/23.
//

import AppKit
import WebKit

class StartingPointViewController : NSViewController {
    
    var yellowBackgroundView: NSView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        
        // This view has the same background color as the webview body.
        // This appears to have no visible effect, but helps demonstrate
        // that putting solid background behind the scrollable webview does
        // not help.
        self.yellowBackgroundView = YellowBackgroundView(frame: self.view.bounds)
        self.view.addSubview(yellowBackgroundView)

        self.webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView)
        let fileUrl = Bundle.main.url(forResource: "startingpoint", withExtension: "html")!
        let data = try! Data(contentsOf: fileUrl)
        let html = String(data: data, encoding: .utf8)!
        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
}
