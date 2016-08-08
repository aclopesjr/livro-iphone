//
//  ListaCarrosViewController.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "ListaCarrosViewController.h"
#import "CarroService.h"
#import "Carro.h"
#import "Alerta.h"
#import "DetalhesCarroViewController.h"
#import "CarroTableViewCell.h"

@interface ListaCarrosViewController ()

@end

@implementation ListaCarrosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Carros"];
    [self setAutomaticallyAdjustsScrollViewInsets:false];
    
    tipo = @"classicos";
    [self buscaCarros];
    
    //[tabView setDelegate:self];
    
    //[tabView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [tabView registerNib:[UINib nibWithNibName:@"CarroTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alterarTipo:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 1:
            tipo = @"esportivos";
            break;
        case 2:
            tipo = @"luxo";
            break;
        default:
            tipo = @"classicos";
            break;
    }
    [self buscaCarros];
}

- (void)buscaCarros {
    carros = [CarroService getCarroByTypeFromFile:tipo];
    [tabView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return carros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Carro * carro = carros[indexPath.row];
    
    CarroTableViewCell * cell = [tabView dequeueReusableCellWithIdentifier:@"cell"];
    cell.lNome.text = carro.nome;
    cell.lDescricao.text = carro.desc;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:carro.url_foto]];
    cell.ivImage.image = [UIImage imageWithData:data];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Carro * carro = carros[indexPath.row];
    //[Alerta alerta:[NSString stringWithFormat:@"Selecionou o carro %@", carro.nome] withViewController:self];
    
    DetalhesCarroViewController * detalhesCarroViewController = [[DetalhesCarroViewController alloc] initWithNibName:@"DetalhesCarroViewController" bundle:nil];
    detalhesCarroViewController.carro = carro;
    
    [[self navigationController] pushViewController:detalhesCarroViewController animated:true];
}

@end
