////
////  MountainFinderController.swift
////  goSki
////
////  Created by Eric Partridge on 2/6/19.
////  Copyright © 2019 hhr. All rights reserved.
////
//
//import UIKit
//import GoogleMaps
//import GooglePlaces
//import CoreLocation
//
//class MountainFinderController: UIViewController, CLLocationManagerDelegate {
//    
//    let mountainModel = skiMountainData()
//    
//    
//    var placesClient: GMSPlacesClient?
//    var locationManager = CLLocationManager()
//    lazy var mapView = GMSMapView()
//    var currentLocation: CLLocation!
//    //var skiMountains: [skiMountain] = []
//    var mountainMarkers = [GMSMarker]()
//    
//    typealias JSONDictionary = [String: Any]
//    
//    //Struct to hold information about each ski mountain
//    /*struct skiMountain : Hashable {
//     var name: String
//     var lat: Double
//     var long: Double
//     var address: String
//     var hashValue: Int { return lat.hashValue + long.hashValue }
//     
//     func getString(){ print(name + " at lat: " + String(lat) + " long: " + String(long)) }
//     func getName() -> String { return name }
//     func getLat() -> Double { return lat }
//     func getLong() -> Double { return long}
//     func getAddress() -> String { return address }
//     }*/
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //creates initial map view
//        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 8)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        self.view = mapView
//        
//        //requests authorization to use location
//        locationManager.requestAlwaysAuthorization()
//        self.locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
//    
//    
//    override func loadView() {
//        
//    }
//    
//    //called when startUpdatingLocation is called
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //gets user location
//        let userLocation = locations.last
//        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
//        //moves the camera to the users current location and shows their current location on the map
//        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,                                                  longitude: userLocation!.coordinate.longitude, zoom: 8)
//        
//        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
//        mapView.isMyLocationEnabled = true
//        self.view = mapView
//        
//        //function call to get nearest 20 mountains
//        mountainModel.getNearbyMountains(lat: locationManager.location!.coordinate.latitude, long: locationManager.location!.coordinate.longitude)
//        //adds a marker for each mountain
//        addMarkers()
//        
//        //stops updating the location
//        locationManager.stopUpdatingLocation()
//    }
//    
//    /*func getNearbyMountains(lat: Double, long: Double){
//     //creates url string for google places request
//     let mainURL: String = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=ski+mountains+near+me"
//     let locationParam: String = "&location=" + String(lat) + "," + String(long)
//     let radiusParam: String = "&radius=50000"
//     let keyParam: String = "&key=AIzaSyBW5tKbCE5fjbWBKde2menPdnCYkTQLq1E"
//     let urlAddress: String = mainURL + locationParam + radiusParam + keyParam
//     
//     do{
//     //makes url request
//     if let url = URL(string: urlAddress){
//     let data = try Data(contentsOf: url)
//     let json = try JSONSerialization.jsonObject(with: data, options: [])
//     //if json return is already a dictionary
//     if let object = json as? [String: Any]{
//     for (key, value) in object {
//     if(key == "results"){
//     //create a skiMountain struct for each returned place
//     createMountains(results: value as! NSArray)
//     }
//     }
//     }
//     //rest is error handling should never reach this point
//     else if let object = json as? [Any]{
//     print("not dict")
//     }
//     else{
//     print("Json is invlaid")
//     }
//     }
//     else{
//     print("no file")
//     }
//     }
//     catch{
//     print("*******ERROR**********")
//     }
//     }
//     
//     //creates each skiMountain struct
//     func createMountains(results: NSArray){
//     var mountainName: String?
//     var mountainLat: Double?
//     var mountainLong: Double?
//     var mountainAddress: String?
//     //loops through each returned mountain getting necessary information
//     for item in results{
//     let obj = item as! NSDictionary
//     for (key, value) in obj{
//     if(key as! String == "name"){
//     mountainName = value as! String
//     }
//     else if (key as! String == "geometry"){
//     let geometry = value as! NSDictionary
//     for(key, value) in geometry{
//     if(key as! String == "location"){
//     let location = value as! NSDictionary
//     for(key, value) in location{
//     if(key as! String == "lat"){
//     mountainLat = value as! Double
//     }
//     else if(key as! String == "lng"){
//     mountainLong = value as! Double
//     }
//     }
//     }
//     }
//     }
//     else if(key as! String == "formatted_address"){
//     mountainAddress = value as! String
//     }
//     }
//     //creates the skiMountain struct and adds it to a list
//     let tempMountain = skiMountain(name: mountainName!, lat: mountainLat!, long: mountainLong!, address: mountainAddress!)
//     skiMountains.append(tempMountain)
//     }
//     }*/
//    
//    //func to add a marker for each mountain to the map
//    func addMarkers(){
//        mountainMarkers.removeAll()
//        mapView.clear()
//        for currMountain in mountainModel.getSkiMountainData() {
//            let mountainMarker = GMSMarker()
//            mountainMarker.position = CLLocationCoordinate2D(latitude: currMountain.getLat(), longitude: currMountain.getLong())
//            mountainMarker.title = currMountain.getName()
//            mountainMarker.map = mapView
//            mountainMarkers.append(mountainMarker)
//        }
//        mountainModel.setMountainMarkers(markers: mountainMarkers)
//    }
//}
