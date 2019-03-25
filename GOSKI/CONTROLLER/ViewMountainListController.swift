//
//  ViewMountainListController.swift
//  GOSKI
//
//  Created by Eric Partridge on 3/24/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit


class ViewMountainListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mountainModel = skiMountainData.sharedInstance.getSkiMountainData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return mountainModel.getSkiMountainData().count
        print("size of model: ")
        print(mountainModel.count)
        return mountainModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mountainCell", for: indexPath) as? mountainCell {
            let tempMountain = mountainModel[indexPath.row]
            cell.configureCell(mountain: tempMountain)
            print("Possibly configured***********")
            return cell
        }
        else {
            print("Failed*******")
            return mountainCell()
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "mountainCell", for: indexPath)
//        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
