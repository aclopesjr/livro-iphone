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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
