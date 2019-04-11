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
    let mountainModel = skiMountainData.sharedInstance.getSkiMountainData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MountainName.text = mountainModel[myIndex]._name
        MountainAddress.text = mountainModel[myIndex]._address
        let tempDist: Double = Double(round(10*mountainModel[myIndex]._distance)/10)
        MountainDistance.text = "\(tempDist) miles away"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
