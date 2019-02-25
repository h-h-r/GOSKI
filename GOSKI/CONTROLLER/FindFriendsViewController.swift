//
//  FindFriendsViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 2/25/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase

class FindFriendsViewController: UIViewController {

    var userEmail = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail = Auth.auth().currentUser!.email!
        print(userEmail)
        print(userEmail.prefix(userEmail.count-4))
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":true])
//        Database.database().reference().child("\(userEmail.prefix(userEmail.count-4))")
//        Auth.auth().currentUser!.email.hashValue
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        userEmail = Auth.auth().currentUser!.email!
//        print(userEmail)
//        print(userEmail.prefix(userEmail.count-4))
        Database.database().reference().child("USERS").child("\(userEmail.prefix(userEmail.count-4))").updateChildValues(["shareLocation":false])
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
