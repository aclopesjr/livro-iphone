//
//  MapViewController.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 9/2/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Carro.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    CLLocationManager * locManager;
    MKPointAnnotation * pin;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, assign) Carro *carro;


@end
