//
//  IntermediateTutorialController.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/14/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import WebKit

class IntermediateTutorialController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let videoTitles: [String] = ["Introduction to Skiing Parallel", "Clutch / Accelerator Exercise", "Rounded Turns to Control Speed", "Turn Shape", "Edging"]
    let videoURLS: [String] = ["https://www.youtube.com/embed/bAsGPnEYzLE", "https://www.youtube.com/embed/DTkyqZjUMYQ", "https://www.youtube.com/embed/M4_HZfGTunw", "https://www.youtube.com/embed/ya9utfEz6sA", "https://www.youtube.com/embed/SIFDZVFYfJo"]
    
    
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
