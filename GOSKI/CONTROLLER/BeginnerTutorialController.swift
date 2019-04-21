//
//  BeginnerTutorialController.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/14/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import WebKit

class BeginnerTutorialController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let videoTitles: [String] = ["The Snow Plough", "Snow Plough Turns", "Committing to the Downhill Ski", "Commitment Exercise", "Preparing to ski Parallel"]
    let videoURLS: [String] = ["https://www.youtube.com/embed/tXUbCPuc4nw", "https://www.youtube.com/embed/bEBIAfZ0iW4", "https://www.youtube.com/embed/jkZ-8NKD1V0", "https://www.youtube.com/embed/TSodL9uBKqc", "https://www.youtube.com/embed/ppYRE3-kmp0"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        //self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.estimatedRowHeight = 120
        
        self.tableView.reloadData()
    }
    
    
    //gets number of rows in table for displaying mountains
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //configures each individual cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tutorialCell", for: indexPath) as? tutorialCell {
            cell.configureCell(videoName: videoTitles[indexPath.row], videoURL: videoURLS[indexPath.row])
            //print("Possibly configured***********")
            return cell
        }
        else {
            print("Failed*******")
            return tutorialCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

