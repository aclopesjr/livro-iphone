//
//  SobreViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "SobreViewController.h"
#define URL_SOBRE @"http://www.livroiphone.com.br/carros/sobre.htm"

@interface SobreViewController ()

@end

@implementation SobreViewController

@synthesize webView, progress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sobre";
    
    [[self progress] startAnimating];
    
    NSURL *url = [NSURL URLWithString:URL_SOBRE];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[self webView] loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [[self progress] stopAnimating];
}

@end
