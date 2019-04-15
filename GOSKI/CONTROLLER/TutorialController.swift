//
//  BegginerTutorialController.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/14/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import WebKit

class BegginerTutorialController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var videoView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoView = WKWebView(frame: CGRect(x: 16, y: 118, width: 343, height: 216), configuration: WKWebViewConfiguration())
        webView.addSubview(videoView)
        self.view = webView
        
        videoView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/_2zESNSSckA")!))
    }

}
