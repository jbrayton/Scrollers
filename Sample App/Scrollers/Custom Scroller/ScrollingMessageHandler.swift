//
//  ScrollingMessageHandler.swift
//  Scrollers
//
//  Created by John Brayton on 5/13/23.
//

import Foundation
import WebKit

class ScrollingMessageHandler : NSObject, WKScriptMessageHandler {
    
    private let imageUrlPrefix = "unread-image-"

    weak var customScrollerViewController: CustomScrollerViewController?
    
    var lastMessageReceivedTs: TimeInterval?
    
    init( customScrollerViewController: CustomScrollerViewController ) {
        self.customScrollerViewController = customScrollerViewController
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let messageBody = message.body as? [String:Any], let name = messageBody["name"] as? String else {
            return
        }
        let parameters = messageBody["parameters"] as? [String:Any]
        if name == "user_scrolled", let parameters {
            
            let currentTs = Date().timeIntervalSince1970
            if let lastMessageReceivedTs = self.lastMessageReceivedTs {
                let elapsedTime = currentTs - lastMessageReceivedTs
                print("time since last message: ", elapsedTime)
            }
            self.lastMessageReceivedTs = currentTs
            
            self.handleUserScroll(parameters: parameters)
        }
    }
    
    func handleUserScroll( parameters: [String:Any] ) {
        if let position = parameters["position"] as? CGFloat, let viewHeight = parameters["viewHeight"] as? CGFloat, let contentHeight = parameters["contentHeight"] as? CGFloat {
            let scrollState = ScrollState(position: position, viewHeight: viewHeight, contentHeight: contentHeight)
            self.customScrollerViewController?.updateScrollState(scrollState: scrollState)
        }
    }
    
}
