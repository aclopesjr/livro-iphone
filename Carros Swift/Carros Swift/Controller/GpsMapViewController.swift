//
//  GpsMapViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 10/18/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit
import MapKit

class GpsMapViewController: MapViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: GPS
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locManager.delegate = self
        self.locManager.distanceFilter = 100.00
        self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        self.locManager.startUpdatingLocation()
    }

    deinit {
        self.locManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocaltion = locations[locations.count-1] as CLLocation
        let latitude = newLocaltion.coordinate.latitude
        let longitude = newLocaltion.coordinate.longitude
        print("didUpdateLocation lat: \(latitude), lng: \(longitude)")
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(location, animated: true)
        
        self.pin.coordinate = center
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager.didFailWithError: \(error)")
    }
}
