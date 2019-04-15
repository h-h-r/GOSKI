//
//  PriceCell.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/15/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {


    @IBOutlet weak var priceDescription: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    
    //adds text to each cell for ticket prices
    func configureCell(mountain: skiMountain, index: Int){
        priceDescription.text = mountain._ticketTypes[index] as? String
        ticketPrice.text = "$\(mountain._prices[index])"
        
    }

}
