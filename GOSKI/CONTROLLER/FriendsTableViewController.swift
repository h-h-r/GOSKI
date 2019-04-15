//
//  FriendsTableViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 3/19/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase
import SwipeCellKit


class FriendsTableViewController: SwipeTableTableViewController {
    

    
    var userEmail = ""

    var requests = [String]()
    var friends = [FriendItem]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* update USERS.shareLocation state to true */
        userEmail = Auth.auth().currentUser!.email!
//        loadFriendItems()
        
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])
        /*get friends from DB*/
//        retrieveFriends()
        self.retrieveSelectedProperty()
        self.friends = internalFriendsVariable
//        print(<#T##items: Any...##Any#>)
        /*retrieve friends requests*/
        retrieveFriendRequests()
    }

    //==================================================
    func retrieveFriends() {
        let friendsDB = Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("friends")
        friendsDB.observe(.childAdded) { (DataSnapshot) in
            let snapShotValue = DataSnapshot.value as! String
            print(snapShotValue)
            if !self.friends.contains(where: {$0.friendEmail == snapShotValue}){
                let tmpFriendItem = FriendItem()
                tmpFriendItem.friendEmail = snapShotValue
                self.friends.append(tmpFriendItem)

            }

            self.configureTableView()
            print(self.friends)
            self.tableView.reloadData()
        }
    }
    
    func retrieveSelectedProperty(){
        let friendsIWantDB = Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("friendsIWant")
        friendsIWantDB.observe(.childAdded) { (DataSnapshot) in
            let snapShotValue = DataSnapshot.value as! String
            for friendItem in self.friends{
                if friendItem.friendEmail == snapShotValue{
                    friendItem.selected = true
                    self.tableView.reloadData()
                }
            }
        }
    }

    func retrieveFriendRequests(){
        let friendRequestsDB = Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").child("friendRequestsList")
        
        friendRequestsDB.observe(.childAdded, with: { (snapshot) in
            
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
                Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friends").child("\(friendEmail.prefix(friendEmail.count-4))").setValue("\(friendEmail)")
//                setValue(["email:":"\(friendEmail)","selected:":false])
                //add current user to senders's friend list
                Database.database().reference().child("USERS").child("\(friendEmail.prefix(friendEmail.count-4))").child("friends").child("\(self.userEmail.prefix(self.userEmail.count-4))").setValue("\(self.userEmail)")
//                    .setValue(["email:":"\(self.userEmail)","selected:":false])
                //remove sender from current user's request list
                Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friendRequestsList").child("\(self.requests.first!.prefix(self.requests.first!.count-4))").removeValue()
                
                self.requests.removeFirst()
                self.retrieveFriends()
                self.tableView.reloadData()
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
    //==========================table view required methods========================
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            let removeEmail = self.friends[indexPath.row].friendEmail
            self.friends.remove(at: indexPath.row)
            Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friends").child("\(removeEmail.prefix(self.userEmail.count-4))").removeValue()
            Database.database().reference().child("USERS").child("\(removeEmail.prefix(self.userEmail.count-4))").child("friends").child("\(self.userEmail.prefix(self.userEmail.count-4))").removeValue()
            print(removeEmail)
            //            self.friendTableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    override func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! SwipeTableViewCell
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//        cell.delegate = self
        cell.textLabel?.text = self.friends[indexPath.row].friendEmail
        cell.accessoryType = self.friends[indexPath.row].selected == true ? .checkmark : .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("friends count: ",self.friends.count)
        return self.friends.count
        //        return 1
        
    }
    
    func configureTableView(){
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.friends[indexPath.row].selected = !self.friends[indexPath.row].selected
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        let tmpemail = self.friends[indexPath.row].friendEmail
        if self.friends[indexPath.row].selected == true {
            
            Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friendsIWant").child("\(tmpemail.prefix(tmpemail.count-4))").setValue("\(tmpemail)")

        }else{
            Database.database().reference().child("USERS").child("\(self.userEmail.prefix(self.userEmail.count-4))").child("friendsIWant").child("\(tmpemail.prefix(tmpemail.count-4))").removeValue()

        }
        
        
    }
    


}
