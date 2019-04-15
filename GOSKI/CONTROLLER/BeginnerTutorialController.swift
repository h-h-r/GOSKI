//
//  BeginnerTutorialController.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/14/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import WebKit

class BeginnerTutorialController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    var videoView1: WKWebView!
    var videoView2: WKWebView!
    var videoView3: WKWebView!
    var videoView4: WKWebView!
    var videoView5: WKWebView!
    var videoView6: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creates view for each video and adds it to the main view and then embeds the video in it
        videoView1 = WKWebView(frame: CGRect(x: 8, y: 168, width: 359, height: 202), configuration: WKWebViewConfiguration())
        mainView.addSubview(videoView1)
        
        videoView2 = WKWebView(frame: CGRect(x: 8, y: 421, width: 359, height: 202), configuration: WKWebViewConfiguration())
        mainView.addSubview(videoView2)
        
        videoView3 = WKWebView(frame: CGRect(x: 8, y: 674, width: 359, height: 202), configuration: WKWebViewConfiguration())
        mainView.addSubview(videoView3)
        
        videoView4 = WKWebView(frame: CGRect(x: 8, y: 927, width: 359, height: 202), configuration: WKWebViewConfiguration())
        mainView.addSubview(videoView4)
        
        videoView5 = WKWebView(frame: CGRect(x: 8, y: 1180, width: 359, height: 202), configuration: WKWebViewConfiguration())
        mainView.addSubview(videoView5)
        
        self.view = mainView
        
        videoView1.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/tXUbCPuc4nw")!))
        videoView2.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/bEBIAfZ0iW4")!))
        videoView3.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/jkZ-8NKD1V0")!))
        videoView4.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/TSodL9uBKqc")!))
        videoView5.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/ppYRE3-kmp0")!))
        
    }
    
}
