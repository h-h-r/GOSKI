//
//  RegisterViewController.swift
//  goSki
//
//  Created by Haoran Hu on 1/28/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var confirmPassWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayUIAlert(title: String, text: String, buttonText: String){
        let alert = UIAlertController(title: "\(title)", message: "\(text)", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: NSLocalizedString("\(buttonText))", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"\(buttonText)\" alert occured.")
        }))
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        //user entered two different passwords
        if passWordTextField.text != confirmPassWordTextField.text{
            displayUIAlert(title: "Registration Failed", text: "You've entered two different password.", buttonText: "OK")
            SVProgressHUD.dismiss()
        // try connect to server and register
        }else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passWordTextField.text!) {
                (authDataResult, error) in
                // received eorror
                if error != nil{
                    self.displayUIAlert(title: "registration failed", text: "\(error!.localizedDescription)", buttonText: "OK")
                    SVProgressHUD.dismiss()
                //registration successful
                }else{
                    SVProgressHUD.dismiss()
                    print("registration successful!")
                    self.performSegue(withIdentifier: "goToHomeFromRegister", sender: self)
                }
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
