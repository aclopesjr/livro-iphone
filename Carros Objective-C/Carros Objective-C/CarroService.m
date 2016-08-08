//
//  CarroService.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "CarroService.h"
#import "Carro.h"
#import "XMLCarroParser.h"

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

+ (NSArray *) getCarroByTypeFromFile:(NSString *)tipo {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"carros_%@", tipo] ofType:@"xml"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    return [CarroService parserXML_SAX:data];
}

+ (NSArray *) parserXML_SAX:(NSData *)data {
    if (data.length == 0) {
        return [NSArray alloc];
    }
    
    NSXMLParser * xmlParser = [[NSXMLParser alloc] initWithData:data];
    XMLCarroParser * carroParser = [XMLCarroParser alloc];
    [xmlParser setDelegate:carroParser];
    
    if (xmlParser.parse) {
        return carroParser.carros;
    }
    
    return [NSArray alloc];
}
@end
