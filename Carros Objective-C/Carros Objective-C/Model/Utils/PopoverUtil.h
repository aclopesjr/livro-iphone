//
//  PopoverUtil.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 12/27/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

@interface PopoverUtil : NSObject

+ (void)show:(UIViewController*)selfViewController andViewController:(UIViewController*)viewController andSourceView:(UIView*)sourceView andWidth:(CGFloat)width andHeight:(CGFloat)height;
+ (void)show:(UIViewController*)selfViewController andViewController:(UIViewController*)viewController andSource:(UIBarButtonItem*)sourceView andWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
