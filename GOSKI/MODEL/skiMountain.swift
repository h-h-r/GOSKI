//
//  skiMountain.swift
//  GOSKI
//
//  Created by Eric Partridge on 3/24/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit

class skiMountain {
    var _name: String!
    var _lat: Double!
    var _long: Double!
    var _address: String!
    var _distance: Double!
    
    var name: String {
        if _name == nil{
            _name = ""
        }
        return _name
    }
    
    var lat: Double {
        if _lat == nil{
            _lat = 0
        }
        return _lat
    }
    
    var long: Double {
        if _long == nil{
            _long = 0
        }
        return _long
    }
    
    var address: String{
        if _address == nil{
            _address = ""
        }
        return _address
    }
    
    var distance: Double{
        if _distance == nil{
            _distance = 0
        }
        return _distance
    }
    
    init(mountainName: String, mountainLat: Double, mountainLong: Double, mountainAddress: String, mountainDistance: Double){
        self._name = mountainName
        self._lat = mountainLat
        self._long = mountainLong
        self._address = mountainAddress
        self._distance = mountainDistance
    }
    
   // var hashValue: Int { return lat.hashValue + long.hashValue }
    
//    func getString(){ print(name + " at lat: " + String(lat) + " long: " + String(long) + " and is " + String(distance) + " miles away") }
//    func getName() -> String { return name }
//    func getLat() -> Double { return lat }
//    func getLong() -> Double { return long}
//    func getAddress() -> String { return address }
//    func getDistance() -> Double { return distance }
}
