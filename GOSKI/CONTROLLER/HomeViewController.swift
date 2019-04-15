//
//  HomeViewController.swift
//  goSki
//  1
//  Created by Haoran Hu on 2/11/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class HomeViewController: UIViewController {
    var isGuest: Bool = false;
    
    @IBOutlet weak var findFriendButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var disscussionForumButton: UIButton!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        if self.isGuest == true{
            let alert = UIAlertController(title: "Guest", message: "Some features are disabled as a guest.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert,animated: true,completion: nil)
            self.findFriendButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.disscussionForumButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.findFriendButton.isEnabled = false
            self.disscussionForumButton.isEnabled = false
            backButton.title = "< Back"
        }

    }

    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {

        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            print("log out successful!")
        }catch{
            print("error , a problem signing out")
        }
    }    
}
