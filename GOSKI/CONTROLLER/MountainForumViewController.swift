//
//  MountainForumViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 4/14/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase


class MountainForumViewController: ChatViewController {

    var moutainName = ""
    let mountainModel = skiMountainData.sharedInstance.getSkiMountainData()
    
    override func viewDidLoad() {
        
        /*find the DB path*/
        self.moutainName = mountainModel[myIndex]._name
        self.moutainName = self.moutainName.replacingOccurrences(of: " ", with: "")
        print(self.moutainName)
        
        super.viewDidLoad()
    }
    
   override func retrieveMessages(){
//        let messageDB = Database.database().reference().child("FORUM")
        let messageDB = Database.database().reference().child("MOUNTAINFORUM").child("\(self.moutainName)")

        messageDB.observe(.childAdded) { (snapshot) in
            let snapShotValue = snapshot.value as! Dictionary<String,String>
            let text = snapShotValue["messageBody"]!
            let sender = snapShotValue["sender"]!
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
            self.messageTableView.scrollToRow(at: IndexPath(item: self.messageArray.count-1, section: 0), at: .bottom, animated: false)
        }
    }
    
    @IBAction override func sendPressed(_ sender: UIButton) {
        messageTextField.endEditing(true)
        //Send the message to Firebase and save it in our database
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        if messageTextField.text!.count > 0{
            
//            let messageDB = Database.database().reference().child("FORUM")
            let messageDB = Database.database().reference().child("MOUNTAINFORUM").child("\(self.moutainName)")
            let messageDictionary = ["sender":Auth.auth().currentUser?.email,"messageBody": messageTextField.text!]
            
            messageDB.childByAutoId().setValue(messageDictionary){
                (error,reference) in
                if error != nil {
                    print(error!)
                }else{
                    print("message saved successfully!")
                    self.messageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                    self.messageTextField.text = ""
                    //  self.messageTableView.scrollToRow(at: IndexPath(item: self.messageArray.count-1, section: 0), at: .bottom, animated: true)
                }
            }
        }else{
            self.messageTextField.isEnabled = true
            self.sendButton.isEnabled = true
            //            self.messageTableView.scrollToRow(at: IndexPath(item: self.messageArray.count-1, section: 0), at: .bottom, animated: true)
        }
        
    }
    
}
