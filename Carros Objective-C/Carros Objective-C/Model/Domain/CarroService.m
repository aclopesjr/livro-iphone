//
//  CarroService.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "CarroService.h"
#import "Carro.h"
#import "CarroDBCoreData.h"
#import "XMLCarroParser.h"
#import "SMXMLDocument.h"

@implementation CarroService
+ (NSArray *) getCarros {
    
    NSMutableArray * carros = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < 10; index++) {
        Carro * newCarro = [CarroDBCoreData newInstance];
        newCarro.nome = [NSString stringWithFormat:@"Ferrari %li", (long)index];
        newCarro.desc = [NSString stringWithFormat:@"Desc Ferrari %li", (long)index];
        newCarro.url_foto = @"ferrari_ff.png";
        
        [carros addObject:newCarro];
    }
    
    return carros;
}

+ (NSArray *) getCarroByTypeFromFile:(NSString *)tipo {
    //NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"carros_%@", tipo] ofType:@"xml"];
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"carros_%@", tipo] ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    //return [CarroService parserXML_SAX:data];
    //return [CarroService parserXML_DOM:data];
    return [CarroService parserJSON:data];
}

+ (void) getCarrosByType:(NSString *)tipo withCache:(Boolean)cache andCallback:(void(^)(NSArray*, NSError*))callback {
    
    
    CarroDBCoreData * db = [CarroDBCoreData alloc];
    NSArray<Carro *> * carros = cache ? [db getCarrosByType:tipo] : [NSArray<Carro *> alloc];
    [db close];
    
    if (carros.count > 0) {
        callback(carros, nil);
        return;
    }
    
    NSURLSession * http = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.livroiphone.com.br/carros/carros_%@.json", tipo]];
    
    NSURLSessionDataTask * task = [http dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            callback([[NSArray alloc] init], error);
        } else {
            NSArray * carros = [CarroService parserJSON:data];
            
            if (carros.count > 0) {
                CarroDBCoreData *db = [[CarroDBCoreData alloc] init];
                [db deleteCarrosByType:tipo];
                
                for (Carro *carro in carros) {
                    [carro setTipo:tipo];
                    [db save:carro];
                }
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                callback(carros, nil);
            });
        }
    }];
    [task resume];
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
        Carro *carro = [CarroDBCoreData newInstance];
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

+ (NSArray *) parserJSON:(NSData *)data {
    if (data.length == 0) {
        return [NSArray alloc];
    }
    
    NSMutableArray * carros = [[NSMutableArray alloc] init];
    NSJSONSerialization * dicOp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (dicOp != nil) {
        NSDictionary * jsonCarros = [dicOp valueForKey:@"carros"];
        NSArray * arrayCarros = jsonCarros[@"carro"];
        
        for (NSDictionary * carro in arrayCarros) {
            Carro * newCarro = [CarroDBCoreData newInstance];
            
            [newCarro setNome:carro[@"nome"]];
            [newCarro setDesc:carro[@"desc"]];
            [newCarro setUrl_info:carro[@"url_info"]];
            [newCarro setUrl_foto:carro[@"url_foto"]];
            [newCarro setUrl_video:carro[@"url_video"]];
            [newCarro setLongitude:carro[@"longitude"]];
            [newCarro setLatitude:carro[@"latitude"]];
            
            [carros addObject:newCarro];
        }
    }
    return  carros;
}
@end
