//
//  ViewController.swift
//  goSki
//
//  Created by Haoran Hu on 1/27/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        print("welcome scene: login pressed!")
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        print("welcome scene: register pressed!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeFromGuest" {
            let destVC = segue.destination as! HomeViewController
            destVC.isGuest = true
        }
    }
}

