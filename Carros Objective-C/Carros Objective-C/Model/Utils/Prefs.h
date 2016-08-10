//
//  Prefs.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/10/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prefs : NSObject

+ (void) setObjectForKey:(id)valor withChave:(NSString *)chave;
+ (void) setIntegerForKey:(NSInteger)valor withChave:(NSString *)chave;
+ (NSObject *) getObjectForKey:(NSString *)chave;

@end
