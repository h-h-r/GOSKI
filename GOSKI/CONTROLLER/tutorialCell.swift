//
//  tutorialCell.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/21/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import WebKit

class tutorialCell: UITableViewCell {
    
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoView: WKWebView!
    
    //creates cell for each mountain
    func configureCell(videoName: String, videoURL: String){
        videoTitle.text = videoName
        videoView.load(URLRequest(url: URL(string: videoURL)!))
        
    }
    
}
