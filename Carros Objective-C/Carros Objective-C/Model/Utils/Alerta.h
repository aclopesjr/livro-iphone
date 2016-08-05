//
//  Alerta.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Alerta : NSObject
+(void) alerta:(NSString *)message withViewController:(UIViewController *)viewController;
@end
