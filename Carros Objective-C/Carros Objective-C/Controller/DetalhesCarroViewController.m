//
//  DetalhesCarroViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "DetalhesCarroViewController.h"
#import "MapViewController.h"
#import "GpsMapViewController.h"
#import "VideoViewController.h"
#import "VideoUtil.h"
#import "Utils.h"

@interface DetalhesCarroViewController ()

@end

@implementation DetalhesCarroViewController

@synthesize carro;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (carro != nil) {
        [self updateCarro:carro];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if ([Utils isIphone]) {
        
    }
}

-(IBAction)visualizarMapa:(id)sender {
//    MapViewController *vc = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    GpsMapViewController *vc = [[GpsMapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [vc setCarro:[self carro]];
    [self.navigationController pushViewController:vc animated:true];
}

-(IBAction)visualizarVideo:(id)sender {
    VideoUtil *videoUtil = [[VideoUtil alloc] init];
    NSURL *url = [[NSURL alloc] initWithString:[self.carro url_video]];
    [videoUtil playUrlFullScreen:url withViewController:self];
//    VideoViewController *vc = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
//    [vc setCarro:[self carro]];
//    [self.navigationController pushViewController:vc animated:true];
}

-(void)updateCarro:(Carro*)selectedCarro {
    [self setCarro:selectedCarro];
    [self setTitle:selectedCarro.nome];
    [descricao setText:selectedCarro.desc];
    [image setUrl:selectedCarro.url_foto];
}
@end
