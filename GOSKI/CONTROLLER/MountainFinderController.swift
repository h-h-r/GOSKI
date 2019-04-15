////
////  MountainFinderController.swift
////  goSki
////
////  Created by Eric Partridge on 2/6/19.
////  Copyright © 2019 hhr. All rights reserved.
////
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import SVProgressHUD

class MountainFinderController: UIViewController, CLLocationManagerDelegate {
    
    let mountainModel = skiMountainData.sharedInstance
    
    var placesClient: GMSPlacesClient?
    var locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var currentLocation: CLLocationCoordinate2D!
    var mountainMarkers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        //creates initial map view
        let cameraInit = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 8)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: cameraInit)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        //requests authorization to use location
        print("about to get location")
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        print("1")
        //print(locationManager.location?.coordinate.latitude)
        print("got location")
        
        //function call to get nearest 20 mountains
        mountainModel.getNearbyMountains(lat: locationManager.location!.coordinate.latitude, long: locationManager.location!.coordinate.longitude)
        //adds a marker for each mountain
        addMarkers()
        SVProgressHUD.dismiss()
    }
    
    
    override func loadView() {
        
    }
    
    //called when startUpdatingLocation is called
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //gets user location
        let userLocation = locations.last
        currentLocation = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        //moves the camera to the users current location and shows their current location on the map
        let  cameraGMAPS = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,                                                  longitude: userLocation!.coordinate.longitude, zoom: 8)
        print("shit is as:")
        print(userLocation!.coordinate.latitude)
        //mapView = GMSMapView.map(withFrame: self.view.bounds, camera: cameraGMAPS)
        //mapView.isMyLocationEnabled = true
        mapView.camera = cameraGMAPS
        self.view = mapView
        
        //stops updating the location
        locationManager.stopUpdatingLocation()
    }
    
    //func to add a marker for each mountain to the map
    func addMarkers(){
        mountainMarkers.removeAll()
        //mapView.clear()
        for currMountain in mountainModel.getSkiMountainData() {
            let mountainMarker = GMSMarker()
            mountainMarker.position = CLLocationCoordinate2D(latitude: currMountain.lat, longitude: currMountain.long)
            mountainMarker.title = currMountain.name
            mountainMarker.map = mapView
            mountainMarkers.append(mountainMarker)
        }
        mountainModel.setMountainMarkers(markers: mountainMarkers)
    }
}
