//
//  ChatViewController.swift
//  GOSKI
//
//  Created by Haoran Hu on 4/13/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate {
  
    var messageArray : [Message] = [Message]()
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    var heightKB = 300 //default height of keyboard
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //Set yourself as the delegate of the text field here:
        messageTextField.delegate = self
        
        //Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped) )
        messageTableView.addGestureRecognizer(tapGesture)
        
        //Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessages()
        messageTableView.separatorStyle = .none
//        if (self.messageArray.count>0){
        
//        self.messageTableView.scro
//        }
//        self.messageTableView.scrollToRow(at: self.messageArray.count-1, at: <#T##UITableView.ScrollPosition#>, animated: <#T##Bool#>)
        
//        get height of keyboard
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.heightKB = Int(keyboardRectangle.height)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email{
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        }else{
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        
        return cell
    }
    
    // Declare tableViewTapped here:
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }
    
    // Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
//            self.heightConstraint.constant = 50 + 258
            self.heightConstraint.constant = 50 + CGFloat(self.heightKB)

            self.view.layoutIfNeeded()
        }
    }
    
    
    
    // Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    // Declare configureTableView here:
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }

    
    
    func retrieveMessages(){
        let messageDB = Database.database().reference().child("FORUM")
        
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
    
    @IBAction func sendPressed(_ sender: UIButton) {
        messageTextField.endEditing(true)
        //Send the message to Firebase and save it in our database
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        if messageTextField.text!.count > 0{
   
            let messageDB = Database.database().reference().child("FORUM")
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
//                    self.messageTableView.scrollToRow(at: IndexPath(item: self.messageArray.count-1, section: 0), at: .bottom, animated: true)
                }
            }
        }else{
            self.messageTextField.isEnabled = true
            self.sendButton.isEnabled = true
//            self.messageTableView.scrollToRow(at: IndexPath(item: self.messageArray.count-1, section: 0), at: .bottom, animated: true)
        }
        
    }
}
