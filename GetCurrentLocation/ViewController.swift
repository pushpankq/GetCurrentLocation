//
//  ViewController.swift
//  DrawRouteOnMapKit
//
//  Created by Puspank Kumar on 12/01/19.
//  Copyright © 2019 Puspank Kumar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined
            {
                
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        } else {
            
            print("Please turn on location service or GPS settings")
        }
        
        mapView.showsUserLocation = true
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    // Successfully access the current location and updating it
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    
    // If could not Access the current Location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Enable to update your current location ")
    }
    
}

