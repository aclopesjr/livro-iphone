//
//  CarroService.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "CarroService.h"
#import "Carro.h"

@implementation CarroService
+ (NSArray *) getCarros {
    
    NSMutableArray * carros = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < 10; index++) {
        Carro * newCarro = [Carro alloc];
        newCarro.nome = [NSString stringWithFormat:@"Ferrari %li", (long)index];
        newCarro.desc = [NSString stringWithFormat:@"Desc Ferrari %li", (long)index];
        newCarro.url_foto = @"ferrari_ff.png";
        
        [carros addObject:newCarro];
    }
    
    return carros;
}
@end
