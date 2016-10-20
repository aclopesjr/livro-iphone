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

@interface DetalhesCarroViewController ()

@end

@implementation DetalhesCarroViewController

@synthesize carro;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (carro != nil) {
        [self setTitle:carro.nome];
        
        [image setUrl:carro.url_foto];
        descricao.text = carro.desc;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)visualizarMapa:(id)sender {
//    MapViewController *vc = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    GpsMapViewController *vc = [[GpsMapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [vc setCarro:[self carro]];
    [self.navigationController pushViewController:vc animated:true];
}

-(IBAction)visualizarVideo:(id)sender {
    VideoViewController *vc = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
    [vc setCarro:[self carro]];
    [self.navigationController pushViewController:vc animated:true];
}
@end
