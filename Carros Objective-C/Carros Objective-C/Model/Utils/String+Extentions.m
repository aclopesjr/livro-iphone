//
//  String+Extentions.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 12/26/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "String+Extentions.h"

@implementation NSString

-(NSURL*)url:(NSString*)url {
    return [[NSURL alloc] initWithString:url];
}

@end
