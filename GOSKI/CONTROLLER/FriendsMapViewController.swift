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

var internalFriendsVariable = [FriendItem]()
var internalUserEmail = ""

class FriendsMapViewController: UIViewController,CLLocationManagerDelegate{
    

    var userEmail = ""{
        didSet{
            internalUserEmail = self.userEmail
        }
    }
    var friends = [FriendItem](){
        didSet{
            internalFriendsVariable = friends
            print("????????",internalFriendsVariable)
        }
    }
    var friendsIWant = [String]()

    var locationManager = CLLocationManager()
    var userLongitude : CLLocationDegrees = 0
    var userLatitude : CLLocationDegrees = 0
    @IBOutlet weak var myMap: MKMapView!
    var mapAlreadyCentered = false

    @IBAction func shareLocationSwitchTriggered(_ sender: UISwitch) {
        if sender.isOn {
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])
        }else{
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil
            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":false])
        }
        
    }
    
    
    func retrieveFriendsIWant(){
        
        let friendsIWantDB = Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("friendsIWant")
//        friendsIWantDB.ob
        friendsIWantDB.observe(.childAdded) { (DataSnapshot) in
//        friendsIWantDB.observeSingleEvent(of: .childAdded) { (DataSnapshot) in
            let snapShotValue = DataSnapshot.value as! String
            if !self.friendsIWant.contains(snapShotValue){
                self.friendsIWant.append(snapShotValue)
                print("@@@@@@ ",snapShotValue,self.friendsIWant)
                self.retrieveFriendsLocations(fEmail: snapShotValue)
            }
            
        }
    }
    func retrieveFriendsLocations( fEmail : String){
        var friendSharingLocation = false
//        for fEmail in self.friendsIWant {
            let friendDB = Database.database().reference().child("USERS").child("\(fEmail.prefix(fEmail.count-4))")
            friendDB.child("shareLocation").observe(.value) { (shareLocation) in
                print("\(fEmail): shareLocation: ",shareLocation)
                friendSharingLocation = shareLocation.value as! Bool
                
            if friendSharingLocation == true {
                print("true!!!")
                friendDB.child("location").observe(.value) { (location) in
                    let coordinates = location.value as! [String:CLLocationDegrees]
                    print("\(fEmail)location: ",coordinates["longitude"]!,coordinates["latitude"]!)
                    /* plot this coordinate on the map!!*/
                    for annot in self.myMap.annotations{
                        if annot.title == fEmail{
                            self.myMap.removeAnnotation(annot)
                        }
                    }
                    self.plotFriendsOnMap(email:fEmail,longitude: coordinates["longitude"]!,latitude: coordinates["latitude"]!)
                    
                    print("annotation count => ",self.myMap.annotations.count)
                }
            }else{
                for annot in self.myMap.annotations{
                    if annot.title == fEmail{
                        self.myMap.removeAnnotation(annot)
                    }
                } 
            }
        
            
        }
            
    //        }
    //        let friendDB = Database.database().reference().child("USERS").child("c@c")
    //        friendDB.child("shareLocation").observe(.value) { (DataSnapshot) in
    //            print("shareLocation: ",DataSnapshot)
    //        }
    }
    
    func plotFriendsOnMap(email:String,longitude:CLLocationDegrees,latitude:CLLocationDegrees){
//        for friendItem in internalFriendsVariable{
//            if friendItem.selected == true {
//                //check whether this selected friend is sharing location
//            }
//        }
        let tmpAnnot = MKPointAnnotation()
        tmpAnnot.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        tmpAnnot.title = "\(email)"
//        tmpAnnot
        self.myMap.addAnnotation(tmpAnnot)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        print("----veiwDidAppear")
        self.myMap.removeAnnotations(self.myMap.annotations)
        self.friendsIWant = [String]()
        retrieveFriendsIWant()
//        print("=============================")
//        for fEmail in self.friendsIWant{
//            print("femail:",fEmail)
//            retrieveFriendsLocations(fEmail: fEmail)
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----veiwDidload")
        self.userEmail = Auth.auth().currentUser!.email!
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])
        /*get friends from DB*/
        retrieveFriends()
//        retrieveFriendsIWant()
//        print("friendsmapview:",internalFriendsVariable)
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
    

    
    //observer
    func retrieveFriends() {
        let friendsDB = Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("friends")
        friendsDB.observe(.childAdded) { (DataSnapshot) in
            let snapShotValue = DataSnapshot.value as! String
//            print(snapShotValue)
            if !self.friends.contains(where: {$0.friendEmail == snapShotValue}){
                let tmpFriendItem = FriendItem()
                tmpFriendItem.friendEmail = snapShotValue
                self.friends.append(tmpFriendItem)
                
            }
            
//            self.configureTableView()
//            print(self.friends)
//            self.tableView.reloadData()
        }
    }
   
    func prettyPrintFriendItem(friendItems : [FriendItem]){
        for item in friendItems{
            print("====>friendEmail:",item.friendEmail)
            print("selected:",item.selected)
//            print("locationReady:",item.locationReady)
//            print("location:",item.location)
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if (self.isMovingToParent){
        if self.navigationController?.topViewController?.title! == "Home"{
            print("ppppppppppppppppppp")
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil
            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":false])
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        sup
//
//            print("yyyyyyyyes")
//
//    }
    
    
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

      



    }


    func centerUser(){
        let center = CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.myMap.setRegion(region, animated: true)
//        let center2 = CLLocationCoordinate2D(latitude: self.userLatitude-3, longitude: self.userLongitude-3)
//        let region2 = MKCoordinateRegion(center: center2, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//        self.myMap.setRegion(region2, animated: true)
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



//extension FriendsMapViewController : MKAnnotationView{
////    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
////        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
////        clusteringIdentifier = "unicycle"
////    }
//
//}
