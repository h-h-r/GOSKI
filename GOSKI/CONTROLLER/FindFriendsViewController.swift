//
//  FindFriendsViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 2/25/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class FindFriendsViewController: UIViewController,CLLocationManagerDelegate {

    var userEmail = ""
    var locationManager = CLLocationManager()
    
    //    var latitude :
//    var longitude :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* update USERS.shareLocation state to true */
        userEmail = Auth.auth().currentUser!.email!
        print(userEmail)
        print(userEmail.prefix(userEmail.count-4))
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])
        
        /*setup coreLocationManager */
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("location").updateChildValues(["location":[location.coordinate.longitude,location.coordinate.latitude]])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        userEmail = Auth.auth().currentUser!.email!
//        print(userEmail)
//        print(userEmail.prefix(userEmail.count-4))
        /* set FireBase  USERS.(currentUserEmailField).shareLocation state to false */
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":false])
        /* locationManager stop updating location*/
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
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
