//
//  SpecificMountainInfo.swift
//  GOSKI
//
//  Created by Eric Partridge on 4/10/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

class SpecificMountainInfo: UIViewController {

    @IBOutlet weak var MountainAddress: UILabel!
    @IBOutlet weak var MountainName: UILabel!
    @IBOutlet weak var MountainDistance: UILabel!
    @IBOutlet weak var MountainPrice: UIButton!
    @IBOutlet weak var MountainWeather: UILabel!
    @IBOutlet weak var MountainTemperature: UILabel!
    @IBOutlet weak var MountainTrails: UILabel!
    
    let mountainModel = skiMountainData.sharedInstance.getSkiMountainData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //adds text to each cell
        MountainName.text = mountainModel[myIndex]._name
        MountainAddress.text = mountainModel[myIndex]._address
        let tempDist: Double = Double(round(10*mountainModel[myIndex]._distance)/10)
        MountainDistance.text = "\(tempDist) miles away"
        if(mountainModel[myIndex]._prices[0] as! String != "-1"){
            MountainPrice.isEnabled = true
            MountainPrice.setTitleColor(UIColor.blue, for: .normal)
            MountainPrice.setTitle("Ticket Prices: >>", for: .normal)
        }
        else{
            MountainPrice.isEnabled = false
            MountainPrice.setTitle("Ticket Prices: Not Available", for: .normal)
        }
        MountainWeather.text = "Weather: " + mountainModel[myIndex]._weather
        MountainTemperature.text = "Temperature: " + mountainModel[myIndex]._temperature
        MountainTrails.text = "Open Trails: " + mountainModel[myIndex]._trails
    }
}
