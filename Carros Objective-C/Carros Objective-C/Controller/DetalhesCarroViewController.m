//
//  DetalhesCarroViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "DetalhesCarroViewController.h"
#import "ListaCarrosViewController.h"
#import "MapViewController.h"
#import "GpsMapViewController.h"
#import "VideoViewController.h"
#import "VideoUtil.h"
#import "Utils.h"
#import "PopoverUtil.h"

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
    
    if ([Utils isIphone]) {
        [self.navigationController pushViewController:vc animated:true];
    } else {
        [PopoverUtil show:self andViewController:vc andSourceView:(UIView*)sender andWidth:600 andHeight:500];
    }
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

-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        UIBarButtonItem *btPopOver = [[UIBarButtonItem alloc] initWithTitle:@"Lista" style:UIBarButtonItemStylePlain target:self action:@selector(onClickPopover)];
        [self.navigationItem setLeftBarButtonItem:btPopOver];
    } else {
        [self.navigationItem setLeftBarButtonItem:nil];
    }
}

-(void)onClickPopover {
    ListaCarrosViewController *listaViewController = [[ListaCarrosViewController alloc] init];
    [PopoverUtil show:self andViewController:listaViewController andSource:self.navigationItem.leftBarButtonItem andWidth:400 andHeight:800];
}
@end
