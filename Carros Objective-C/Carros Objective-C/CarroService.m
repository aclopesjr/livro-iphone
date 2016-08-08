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
#import "SMXMLDocument.h"

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
    //return [CarroService parserXML_SAX:data];
    return [CarroService parserXML_DOM:data];
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

+ (NSArray *) parserXML_DOM:(NSData *)data {
    if (data.length == 0) {
        return [NSArray alloc];
    }
    
    NSMutableArray * carros = [[NSMutableArray alloc] init];
    SMXMLDocument * document =  [SMXMLDocument documentWithData:data error:nil];
    if (document == nil) {
        return carros;
    }
    
    SMXMLElement *root = document.root;
    NSArray * tagCarros = [root childrenNamed:@"carro"];
    
    for (SMXMLElement *xml in tagCarros) {
        Carro *carro = [Carro alloc];
        carro.nome = [xml valueWithPath:@"nome"];
        carro.desc = [xml valueWithPath:@"desc"];
        carro.url_info = [xml valueWithPath:@"url_info"];
        carro.url_foto = [xml valueWithPath:@"url_foto"];
        carro.url_video = [xml valueWithPath:@"url_video"];
        if ([xml valueWithPath:@"longitude"] != nil) {
            carro.longitude = [xml valueWithPath:@"longitude"];
        }
        if ([xml valueWithPath:@"latitude"] != nil) {
            carro.latitude = [xml valueWithPath:@"latitude"];
        }
        [carros addObject:carro];
    }
    return carros;
}
@end
