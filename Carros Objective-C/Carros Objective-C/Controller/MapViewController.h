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
    
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager * locManager;
@property (nonatomic, strong) MKPointAnnotation * pin;
@property (nonatomic, assign) Carro *carro;


@end
