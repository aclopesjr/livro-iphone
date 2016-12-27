//
//  Utils.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 12/27/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (BOOL)isIphone {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isIpad {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)isLandscape {
    return [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ||
           [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight;
}

+ (BOOL)isPortrait {
    return [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait;
}

@end
