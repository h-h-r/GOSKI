//
//  ViewMountainListController.swift
//  GOSKI
//
//  Created by Eric Partridge on 3/24/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

var myIndex = 0

class ViewMountainListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let mountainModel = skiMountainData.sharedInstance.getSkiMountainData()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchMountain: [skiMountain]!
    var searching = false
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        //self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.estimatedRowHeight = 120
        
        self.tableView.reloadData()
    }
    
    
    //gets number of rows in table for displaying mountains
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return mountainModel.getSkiMountainData().count
        if searching{
            return searchMountain.count
        }
        else{
            return mountainModel.count
        }
    }
    
    //configures each individual cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searching{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mountainCell", for: indexPath) as? mountainCell {
                let tempMountain = searchMountain[indexPath.row]
                cell.configureCell(mountain: tempMountain)
                return cell
            }
        }
        else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mountainCell", for: indexPath) as? mountainCell {
                let tempMountain = mountainModel[indexPath.row]
                cell.configureCell(mountain: tempMountain)
                //print("Possibly configured***********")
                return cell
            }
            else {
                print("Failed*******")
                return mountainCell()
            }
        }
        return mountainCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //determines what index a user clicked on if they clicked oin a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "mountainSegue", sender: self)
    }
    
    //searches through list of ski mouintains
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMountain = mountainModel.filter({$0._name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
}
