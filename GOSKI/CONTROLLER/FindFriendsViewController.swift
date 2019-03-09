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
import MapKit


class FindFriendsViewController: UIViewController,CLLocationManagerDelegate {

    var userEmail = ""
    var locationManager = CLLocationManager()
    @IBOutlet weak var myMap: MKMapView!
    var mapAlreadyCentered = false
    var requests = [String]()
    
   
    
    //    var latitude :
//    var longitude :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        /* update USERS.shareLocation state to true */
        userEmail = Auth.auth().currentUser!.email!
//        print(userEmail)
//        print(userEmail.prefix(userEmail.count-4))
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])
        
        retrieveFriendRequests()
        
        /*myMap*/
        self.myMap.showsUserLocation = true
        
        
        /*setup coreLocationManager */
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()

        //read data from firebase!
//        let ref = Database.database().reference().child("USERS").child("h@h").child("friendList")
//        ref.observeSingleEvent(of: .value) { (DataSnapshot) in
//            print("============")
//            if let friendList = DataSnapshot.value as? [String]{
//                print(friendList)
//                print(friendList[0])
//
//            }
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
//            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["location":["longitude":location.coordinate.longitude,"latitude":location.coordinate.latitude]])
            
            if self.mapAlreadyCentered == false{
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.myMap.setRegion(region, animated: true)
                mapAlreadyCentered = true
            }
            
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

   
    @IBAction func addFriendButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Send a friend request", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (UITextField) in
            UITextField.placeholder = "email"
        }
        let saveAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let friendEmail = alertController.textFields![0].text!
//            print(friendEmail)
            self.sendFriendRequest(email: friendEmail)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func sendFriendRequest(email : String ){
        Auth.auth().fetchSignInMethods(forEmail: email, completion: { (methodsArray, Error) in
            if methodsArray == nil{
                let alertController = UIAlertController(title: "Not a valid email", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                    (action : UIAlertAction!) -> Void in })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                print("yes!!!")
                let friendEmail = String(email.prefix(email.count-4))
                print("\(friendEmail)")
//                Database.database().reference().child("\(friendEmail)").setValue("hhhhhhr")
                
                let friendRequestDB = Database.database().reference().child("USERS").child(friendEmail).child("friendRequestsList")
//                friendRequestDB.setValue(self.userEmail.prefix(self.userEmail.count-4))
                print("myemail: \(self.userEmail)")
//                friendRequestDB.updateChildValues(["test":self.userEmail])
//                self.userEmail.prefix(self.userEmail.count-4)
                friendRequestDB.child("\(self.userEmail.prefix(self.userEmail.count-4))").setValue(self.userEmail)
//                friendRequestDB.childByAutoId().setValue(self.userEmail.prefix(self.userEmail.count-4))
//                friendRequestDB.setValue([self.userEmail.prefix(self.userEmail.count-4)] , withCompletionBlock: { (Error, DatabaseReference) in
//                    if Error != nil {
//                        print("eeeeeeeerror",Error!)
//                    }else{
//                        print("new request saved in db successfully!")
//
//                    }
//                })
                
                
//                read data from firebase!
//                let ref = Database.database().reference().child("USERS").child(friendEmail).child("friendRequestsList")
//                ref.observeSingleEvent(of: .value) { (DataSnapshot) in
//                print("============")
//                    if let friendRequest = DataSnapshot.value as? [String]{
//                        print("!!!!!")
//                        print(friendRequest)
//                        print(friendRequest[0])
//                        print(friendRequest[1])
//
//                    }
//                }
            
            }
        })
        
        
    }
    
    func retrieveFriendRequests(){
        let friendRequestsDB = Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("friendRequestsList")
        
        friendRequestsDB.observe(.childAdded, with: { (snapshot) in
//            let snapShotValue = snapshot.value as! Dictionary<String,String>
//            let text = snapShotValue["messageBody"]!
//            let sender = snapShotValue["sender"]!
//                        print(text,sender)
//            let message = Message()
//            message.messageBody = text
//            message.sender = sender
//            self.messageArray.append(message)
//            self.configureTableView()
//            self.messageTableView.reloadData()
            let friendRequestEmail = snapshot.value as? String
            
            if friendRequestEmail != nil {
//                friendRequestsDB.child("\(friendRequestEmail!.prefix(friendRequestEmail!.count-4))").removeValue()
                self.requests.append(friendRequestEmail!)
                self.displayRequests()
                
            }
            
            
        })

    }
    
    func displayRequests(){

        if self.requests.count > 0 {
            //            create an alert for request
            let alertController = UIAlertController(title: "Friend request", message: "\(self.requests[0])", preferredStyle: UIAlertController.Style.alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) { (UIAlertAction) in
                let friendEmail = self.requests.first!
                //add sender to current user's friend list
                Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friends").child("\(friendEmail.prefix(friendEmail.count-4))").setValue(friendEmail)
                //add current user to senders's friend list
                Database.database().reference().child("USERS").child("\(friendEmail.prefix(friendEmail.count-4))").child("friends").child("\(self.userEmail.prefix(self.userEmail.count-4))").setValue(self.userEmail)
                //remove sender from current user's request list
                Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friendRequestsList").child("\(self.requests.first!.prefix(self.requests.first!.count-4))").removeValue()
                
                self.requests.removeFirst()
                self.displayRequests()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                                            (action : UIAlertAction!) -> Void in
               
                Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friendRequestsList").child("\(self.requests.first!.prefix(self.requests.first!.count-4))").removeValue()
                self.requests.removeFirst()
                self.displayRequests()
            })
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        

    }
    
    
}
