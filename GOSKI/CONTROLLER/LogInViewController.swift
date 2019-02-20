//
//  LogInViewController.swift
//  goSki
//
//  Created by Haoran Hu on 1/28/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
//        print("log in pressed!")
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passWordTextField.text!)
        { (authDataResult, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                //login in failed received error from firebase, then pop an alert to UI
                let alert = UIAlertController(title: "Log in failed", message: "\(error!.localizedDescription)", preferredStyle: .alert )
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert,animated: true,completion: nil)
                self.passWordTextField.text = ""
                
            }else{
                print("log in successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToHomeFromLogIn", sender: self)
            }
        }
        
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
