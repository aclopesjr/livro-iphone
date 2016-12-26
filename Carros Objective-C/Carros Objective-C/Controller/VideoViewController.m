//
//  VideoViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 10/20/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    videoUtil = [[VideoUtil alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:self.carro.url_video];
    [videoUtil playUrl:url withView:webView];
    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [webView loadRequest:request];
    
    // Notificações para monitorar o fim
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFim) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Evento
- (void)videoFim {
    [self.navigationController popViewControllerAnimated:TRUE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
