//
//  MountainTicketPrice.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/15/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

class MountainTicketPrice: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let mountainModel = skiMountainData.sharedInstance.getSkiMountainData()
    

    @IBOutlet weak var tableView: UITableView!
    
    var searchMountain: [skiMountain]!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }

    //gets number of different ticket prices
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mountainModel[myIndex]._prices.count
    }
    
    //creates a cell for each ticket price
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as? PriceCell {
            let tempMountain = mountainModel[myIndex]
            cell.configureCell(mountain: tempMountain, index: indexPath.row)
            //print("Possibly configured***********")
            return cell
        }
        return PriceCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
}
