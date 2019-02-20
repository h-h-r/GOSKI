//
//  HomeViewController.swift
//  goSki
//
//  Created by Haoran Hu on 2/11/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    var isGuest: Bool = false;
    
    @IBOutlet weak var findFriendButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        if self.isGuest == true{
            self.findFriendButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.findFriendButton.isEnabled = false
            backButton.title = "< Back"
        }

    }


 
//    @IBAction func findFriendButtonPressed(_ sender: UIButton) {
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
