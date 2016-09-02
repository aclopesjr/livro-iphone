//
//  MapViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 9/2/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "MapViewController.h"
#import "Alerta.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [locManager requestWhenInUseAuthorization];
    
    if (self.carro != nil) {
        double latitude = [self.carro latitude].doubleValue;
        double longitude = [self.carro longitude].doubleValue;
        
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);
        MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion location = MKCoordinateRegionMake(center, span);
        
        [mapView setRegion:location animated:true];
        
        pin = [[MKPointAnnotation alloc] init];
        [pin setCoordinate:location.center];
        [pin setTitle:[NSString stringWithFormat:@"Fábrica %@", [self.carro nome]]];
        
        [self.mapView addAnnotation:pin];
    }
    
    self.mapView.delegate = self;
    [mapView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinView"];
    [pinView setPinTintColor:[UIColor redColor]];
    [pinView setCanShowCallout:true];
    //
    UIButton *btbin = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [pinView setRightCalloutAccessoryView:btbin];
    //
    return  pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [Alerta alerta:@"Opa!" withViewController:self];
}


@end
