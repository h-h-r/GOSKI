//
//  FriendsMapViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 3/19/19.
//  Copyright © 2019 hhr. All rights reserved.
//
import UIKit
import Firebase
import CoreLocation
import MapKit

class FriendsMapViewController: UIViewController,CLLocationManagerDelegate {

    var userEmail = internalUserEmail

    var locationManager = CLLocationManager()
    var userLongitude : CLLocationDegrees = 0
    var userLatitude : CLLocationDegrees = 0
    @IBOutlet weak var myMap: MKMapView!
    var mapAlreadyCentered = false


    override func viewDidLoad() {
        super.viewDidLoad()
        print("friendsmapview:",internalFriendsVariable)
        // Do any additional setup after loading the view.
        /*myMap*/
        self.myMap.showsUserLocation = true
        /*setup coreLocationManager */
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        centerUser()
        prettyPrintFriendItem(friendItems: internalFriendsVariable)

    }
    func prettyPrintFriendItem(friendItems : [FriendItem]){
        for item in friendItems{
            print("====>friendEmail:",item.friendEmail)
            print("selected:",item.selected)
//            print("locationReady:",item.locationReady)
//            print("location:",item.location)
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0{
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["location":["longitude":location.coordinate.longitude,"latitude":location.coordinate.latitude]])
            self.userLatitude = location.coordinate.latitude
            self.userLongitude = location.coordinate.longitude
            if self.mapAlreadyCentered == false{
                centerUser()
                mapAlreadyCentered = true
            }

        }

        func plotFriendsOnMap(){
            for friendItem in internalFriendsVariable{
                if friendItem.selected == true {
                    //check whether this selected friend is sharing location
                }
            }
        }



    }

    @IBAction func centerButtonPressed(_ sender: UIBarButtonItem) {
        centerUser()

    }

    func centerUser(){
        let center = CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.myMap.setRegion(region, animated: true)
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





//import UIKit
//import Firebase
//import CoreLocation
//import MapKit
//
//class FriendsMapViewController: UIViewController,CLLocationManagerDelegate {
//
//    var userEmail = internalUserEmail
//
//    var locationManager = CLLocationManager()
//    var userLongitude : CLLocationDegrees = 0
//    var userLatitude : CLLocationDegrees = 0
//    @IBOutlet weak var myMap: MKMapView!
//    var mapAlreadyCentered = false
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("friendsmapview:",internalFriendsVariable)
//        // Do any additional setup after loading the view.
//        /*myMap*/
//        self.myMap.showsUserLocation = true
//        /*setup coreLocationManager */
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        centerUser()
//        prettyPrintFriendItem(friendItems: internalFriendsVariable)
//
//    }
//    func prettyPrintFriendItem(friendItems : [FriendItem]){
//        for item in friendItems{
//            print("====>friendEmail:",item.friendEmail)
//            print("selected:",item.selected)
////            print("locationReady:",item.locationReady)
////            print("location:",item.location)
//        }
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[locations.count - 1]
//
//        if location.horizontalAccuracy > 0{
//            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
//            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["location":["longitude":location.coordinate.longitude,"latitude":location.coordinate.latitude]])
//            self.userLatitude = location.coordinate.latitude
//            self.userLongitude = location.coordinate.longitude
//            if self.mapAlreadyCentered == false{
//                centerUser()
//                mapAlreadyCentered = true
//            }
//
//        }
//
//        func plotFriendsOnMap(){
//            for friendItem in internalFriendsVariable{
//                if friendItem.selected == true {
//                    //check whether this selected friend is sharing location
//                }
//            }
//        }
//
//
//
//    }
//
//    @IBAction func centerButtonPressed(_ sender: UIBarButtonItem) {
//        centerUser()
//
//    }
//
//    func centerUser(){
//        let center = CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//        self.myMap.setRegion(region, animated: true)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
