//
//  StringsHelper.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/24/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (char *)toCString:(NSString *)s {
    char * result = (char*)[s UTF8String];
    return result;
}

@end
