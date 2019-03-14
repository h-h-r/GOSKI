//
//  skiMountainData.swift
//  goSki
//
//  Created by Eric Partridge on 2/19/19.
//  Copyright © 2019 hhr. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class skiMountainData {
    
    var placesClient: GMSPlacesClient?
    lazy var mapView = GMSMapView()
    var skiMountains: [skiMountain] = []
    var mountainMarkers = [GMSMarker]()
    var userLat: Double?
    var userLong: Double?
    
    typealias JSONDictionary = [String: Any]
    
    
    struct skiMountain : Hashable {
        var name: String
        var lat: Double
        var long: Double
        var address: String
        var distance: Double
        
        var hashValue: Int { return lat.hashValue + long.hashValue }
        
        func getString(){ print(name + " at lat: " + String(lat) + " long: " + String(long) + " and is " + String(distance) + " miles away") }
        func getName() -> String { return name }
        func getLat() -> Double { return lat }
        func getLong() -> Double { return long}
        func getAddress() -> String { return address }
        func getDistance() -> Double { return distance }
    }
    
    func getSkiMountainData() -> [skiMountain] { return skiMountains }
    
    func setMountainMarkers(markers: [GMSMarker]) {
        mountainMarkers = markers
    }
    
    func getNearbyMountains(lat: Double, long: Double){
        //creates url string for google places request
        userLat = 42.738070
        userLong = -73.679348
        let mainURL: String = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=ski+mountains+near+me"
        let locationParam: String = "&location=" + String(format:"%f", userLat!) + "," + String(format:"%f", userLong!)
        let radiusParam: String = "&radius=50000"
        let keyParam: String = "&key=AIzaSyBEGuIqaHs6rxxZ2G9qqFJO0eGJVTp54t0"
        let urlAddress: String = mainURL + locationParam + radiusParam + keyParam
        
        do{
            //makes url request
            if let url = URL(string: urlAddress){
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //if json return is already a dictionary
                if let object = json as? [String: Any]{
                    for (key, value) in object {
                        if(key == "results"){
                            //create a skiMountain struct for each returned place
                            createMountains(results: value as! NSArray)
                        }
                    }
                }
                    //rest is error handling should never reach this point
//                else if let object = json as? [Any]{
//                    print("not dict")
//                }
                else{
                    print("Json is invlaid")
                }
            }
            else{
                print("no file")
            }
        }
        catch{
            print("*******ERROR**********")
        }
    }
    
    //creates each skiMountain struct
    func createMountains(results: NSArray){
        skiMountains.removeAll()
        var mountainName: String?
        var mountainLat: Double?
        var mountainLong: Double?
        var mountainAddress: String?
        //loops through each returned mountain getting necessary information
        for item in results{
            let obj = item as! NSDictionary
            for (key, value) in obj{
                if(key as! String == "name"){
                    mountainName = value as? String
                }
                else if (key as! String == "geometry"){
                    let geometry = value as! NSDictionary
                    for(key, value) in geometry{
                        if(key as! String == "location"){
                            let location = value as! NSDictionary
                            for(key, value) in location{
                                if(key as! String == "lat"){
                                    mountainLat = value as? Double
                                }
                                else if(key as! String == "lng"){
                                    mountainLong = value as? Double
                                }
                            }
                        }
                    }
                }
                else if(key as! String == "formatted_address"){
                    mountainAddress = value as? String
                }
            }
            //creates the skiMountain struct and adds it to a list
            let tempMountain = skiMountain(name: mountainName!, lat: mountainLat!, long: mountainLong!, address: mountainAddress!, distance: requestDistance(mountainLat: mountainLat!, mountainLong: mountainLong!))
            skiMountains.append(tempMountain)
        }
        skiMountains.sort { $0.distance < $1.distance }
    }
    
    func requestDistance(mountainLat: Double, mountainLong: Double) -> Double {
        let mainURL: String = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial"
        let orginsParam: String = "&origins=" + String(format:"%f", userLat!) + "," + String(format:"%f", userLong!)
        let destinationsParam: String = "&destinations=" + String(mountainLat) + "," + String(mountainLong)
        let keyParam: String = "&key=AIzaSyBEGuIqaHs6rxxZ2G9qqFJO0eGJVTp54t0"
        let urlAddress: String = mainURL + orginsParam + destinationsParam + keyParam
        
        do{
            //makes url request
            if let url = URL(string: urlAddress){
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //if json return is already a dictionary
                if let object = json as? [String: Any]{
                    for (key, value) in object {
                        if(key == "rows"){
                            return getDistanceFromUser(results: value as! NSArray)
                        }
                    }
                }
                    //rest is error handling should never reach this point
//                else if let object = json as? [Any]{
//                    print("not dict")
//                }
                else{
                    print("Json is invlaid")
                }
            }
            else{
                print("no file")
            }
        }
        catch{
            print("*******ERROR**********")
        }
        return 0.0;
    }
    
    func getDistanceFromUser(results: NSArray) -> Double{
        for item in results{
            let obj = item as! NSDictionary
            for (key,value) in obj{
                if(key as! String == "elements"){
                    let elements = value as! [[String:Any?]]
                    for info in elements{
                        for(key, value) in info{
                            if(key == "distance"){
                                let distance = value as! NSDictionary
                                for (key, value) in distance {
                                    if(key as! String == "value"){
                                        let meters = value as! Double
                                        return (meters * 0.00062137)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return 0.0
    }
}
