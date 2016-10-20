//
//  GpsMapViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 10/18/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "GpsMapViewController.h"

@interface GpsMapViewController ()

@end

@implementation GpsMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.locManager setDelegate:self];
    [self.locManager setDistanceFilter:100.0];
    [self.locManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    
    [self.locManager startUpdatingLocation];
}	

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GPS

- (void) dealloc {
    [self.locManager stopUpdatingLocation];
}


//-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = [locations lastObject];
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    NSLog(@"didUpdateLocation lat.: %fd, long.: %fd", latitude, longitude);
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion location = MKCoordinateRegionMake(center, span);
    
    [self.mapView setRegion:location animated:true];
    
    self.pin = [[MKPointAnnotation alloc] init];
    [self.pin setCoordinate:location.center];
    
    [self.mapView addAnnotation:self.pin];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager.didFailWithError: %@", error);
}

@end
