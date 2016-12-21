//
//  VideoUtil.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 12/15/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "VideoUtil.h"

@implementation VideoUtil

// Reproduz o vídeo com um player utilizando uma view como conteiner
- (void) playFile:(NSString *)file withView:(UIView *)view {
    NSString * path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    if (path != nil) {
        NSURL * url = [NSURL fileURLWithPath:path];
        [self playUrl:url withView:view];
    }
}

// Reproduz o vídeo com um player utilizando uma view como conteiner
- (void) playUrl:(NSURL *)url withView:(UIView *)view {
    // cria o componente que gerencia o vídeo
    if (player == nil) {
        if (playerVC == nil) {
            playerItem = [[AVPlayerItem alloc] initWithURL:url];
            player =  [[AVPlayer alloc] initWithPlayerItem:playerItem];
            
            playerVC = [[AVPlayerViewController alloc] init];
            playerVC.player = player;
            playerVC.showsPlaybackControls = TRUE;
            playerVC.view.frame = view.frame;
            [[playerVC view] sizeToFit];
            playerVC.videoGravity = AVLayerVideoGravityResizeAspect;
            
            [view addSubview:playerVC.view];
            
            [playerVC.player play];
        }
    }
    // inicia o video
    [player play];
}

- (void) pause {
    [player pause];
}

- (void) stop {
    [player pause];
}

// Reproduz o filme em tela cheia
- (void) playFileFullScreen:(NSString *)file withViewController:(UIViewController *)viewController {
    // converte o nome do arquivo em URL
    NSString * path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    if (path != nil) {
        NSURL * url = [NSURL fileURLWithPath:path];
        [self playUrlFullScreen:url withViewController:viewController];
    }
}

- (void) playUrlFullScreen:(NSURL *)url withViewController:(UIViewController *)viewController {
    // cria o controller especializado em reproduzir vídeo
    if (playerVC == nil) {
        playerItem = [[AVPlayerItem alloc] initWithURL:url];
        player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
        
        playerVC = [[AVPlayerViewController alloc] init];
        playerVC.player = player;
        playerVC.showsPlaybackControls = TRUE;
        playerVC.videoGravity = AVLayerVideoGravityResizeAspect;
        
        [viewController presentViewController:playerVC animated:TRUE completion: ^(void) {
            [playerVC.player play];
        }];
    }
}

@end
