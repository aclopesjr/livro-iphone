//
//  VideoUtil.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 12/15/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface VideoUtil : NSObject {

    AVPlayerViewController * playerVC;
    AVPlayerItem * playerItem;
    AVPlayer * player;
    AVPlayerLayer * playerLayer;
    
}

- (void)playFile:(NSString*) file withView:(UIView*) view;
- (void)playUrl:(NSURL*) url withView:(UIView*) view;
- (void)pause;
- (void)stop;
- (void)playFileFullScreen:(NSString*) file withViewController:(UIViewController*) viewController;
- (void)playUrlFullScreen:(NSURL*) file withViewController:(UIViewController*) viewController;

@end
