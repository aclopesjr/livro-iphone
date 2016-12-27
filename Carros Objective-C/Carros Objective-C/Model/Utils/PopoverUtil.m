//
//  PopoverUtil.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 12/27/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "PopoverUtil.h"

@implementation PopoverUtil

+ (void)show:(UIViewController*)selfViewController andViewController:(UIViewController*)viewController andSourceView:(UIView*)sourceView andWidth:(CGFloat)width andHeight:(CGFloat)height {
    
    [viewController setPreferredContentSize:CGSizeMake(width, height)];
    [viewController setModalPresentationStyle:UIModalPresentationPopover];
    [[viewController popoverPresentationController] setSourceView:sourceView];
    
    [selfViewController presentViewController:viewController animated:true completion:nil];
}

+ (void)show:(UIViewController*)selfViewController andViewController:(UIViewController*)viewController andSource:(UIBarButtonItem*)source andWidth:(CGFloat)width andHeight:(CGFloat)height {
    
    [viewController setPreferredContentSize:CGSizeMake(width, height)];
    [viewController setModalPresentationStyle:UIModalPresentationPopover];
    [[viewController popoverPresentationController] setBarButtonItem:source];
    
    [selfViewController presentViewController:viewController animated:true completion:nil];
}

@end
