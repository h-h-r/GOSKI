//
//  mountainCell.swift
//  GOSKI
//
//  Created by Eric Partridge on 3/24/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

class mountainCell: UITableViewCell {

    @IBOutlet weak var mountainLabel: UILabel!
    @IBOutlet weak var distanceAway: UILabel!
    
    func configureCell(mountain: skiMountain){
        mountainLabel.text = mountain.name
        let tempDist: Double = Double(round(10*mountain.distance)/10)
        distanceAway.text = "\(tempDist) miles away"
        
    }

}
