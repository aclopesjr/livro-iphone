//
//  VideoViewController.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 10/20/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Carro.h"
#import "VideoUtil.h"

@interface VideoViewController : UIViewController {
    IBOutlet UIWebView * webView;
    VideoUtil * videoUtil;
}

@property (nonatomic, assign) Carro *carro;
-(void)videoFim;

@end
