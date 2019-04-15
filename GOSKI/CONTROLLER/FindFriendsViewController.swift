//
//  TempFindFriendsViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 3/19/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase

class FindFriendsViewController: UIViewController {

    var userEmail : String = ""

    @IBOutlet weak var friendListSubView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmail = Auth.auth().currentUser!.email!
        print("======>\n",internalFriendsVariable)
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])

    }

    @IBAction func ProceedToMapButton(_ sender: UIButton) {
        print(internalFriendsVariable)
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
                let friendEmail = String(email.prefix(email.count-4))
                print("\(friendEmail)")


                let friendRequestDB = Database.database().reference().child("USERS").child(friendEmail).child("friendRequestsList")
                friendRequestDB.child("\(self.userEmail.prefix(self.userEmail.count-4))").setValue(self.userEmail)

            }
        })


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
