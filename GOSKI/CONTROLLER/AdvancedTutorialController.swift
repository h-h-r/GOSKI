//
//  AdvancedTutorialController.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/14/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import WebKit

class AdvancedTutorialController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let videoTitles: [String] = ["Dynamic Turns", "How to Pole Plant", "How to Carve on Skis", "How To Ski Bumps / Moguls", "How To Ski Powder"]
    let videoURLS: [String] = ["https://www.youtube.com/embed/btsWG9PH4VE", "https://www.youtube.com/embed/MC5-gg6FQXU", "https://www.youtube.com/embed/UGn62uxnhjg", "https://www.youtube.com/embed/M4yJgn9HdAM", "https://www.youtube.com/embed/N-9jGqY1BQw"]
    
    
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
