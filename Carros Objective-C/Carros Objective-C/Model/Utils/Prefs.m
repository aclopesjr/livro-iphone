//
//  Prefs.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/10/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "Prefs.h"

@implementation Prefs

+ (void) setObjectForKey:(id)valor withChave:(NSString *)chave {
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:valor forKey:chave];
    [prefs synchronize];
}

+ (void) setIntegerForKey:(NSInteger)valor withChave:(NSString *)chave {
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:valor forKey:chave];
    [prefs synchronize];
}

+ (NSObject *) getObjectForKey:(NSString *)chave {
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:chave];
}

@end
