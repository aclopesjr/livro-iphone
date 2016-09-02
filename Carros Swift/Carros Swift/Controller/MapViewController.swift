//
//  MapViewController.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 9/1/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let locManager = CLLocationManager()
    var carro: Carro?
    @IBOutlet var mapView : MKMapView!
    var pin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locManager.requestWhenInUseAuthorization()
        
        if (carro != nil) {
            let lat = (self.carro!.latitude! as NSString).doubleValue
            let long = (self.carro!.longitude! as NSString).doubleValue
            
            let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let location = MKCoordinateRegion(center: center, span: span)
            
            self.mapView.setRegion(location, animated: true)
            
            pin.coordinate = location.center
            pin.title = "Fábrica \(self.carro!.nome)"
            self.mapView.addAnnotation(pin)
        }
        
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        pinView.pinTintColor = UIColor.redColor()
        pinView.canShowCallout = true
        //
        let btPin = UIButton(type: UIButtonType.DetailDisclosure) as UIView
        pinView.rightCalloutAccessoryView = btPin
        
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        Alerta.alerta("Opa!", viewController: self)
    }
}
