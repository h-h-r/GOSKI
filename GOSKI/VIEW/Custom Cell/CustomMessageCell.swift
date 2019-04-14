//
//  CustomMessageCell.swift
//  GOSKI
//
//  Created by Haoran Hu on 4/13/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import Foundation

import UIKit

class CustomMessageCell: UITableViewCell {
    
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
        
        
        
    }
    
    
}
