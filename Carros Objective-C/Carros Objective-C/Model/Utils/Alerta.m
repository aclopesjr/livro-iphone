//
//  Alerta.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alerta.h"

@implementation Alerta
+(void) alerta:(NSString *)message withViewController:(UIViewController *)viewController {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alerta" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [viewController presentViewController:alert animated:true completion:nil];
}
@end
