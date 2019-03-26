//
//  FriendItem.swift
//  GOSKI
//
//  Created by Haoran Hu on 3/18/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import Foundation
import RealmSwift

class FriendItem : Object {
    @objc dynamic var friendEmail : String = ""
    @objc dynamic var selected : Bool = false
//    var locationReady = false
//    var location = [Float]()
    
}
