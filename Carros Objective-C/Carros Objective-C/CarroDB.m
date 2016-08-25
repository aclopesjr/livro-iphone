//
//  CarroDB.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/24/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "CarroDB.h"
#import "sqlite3.h"
#import "SQLiteHelper.h"

@implementation CarroDB

- (id)init
{
    self = [super init];
    if (self) {
        db = [[SQLiteHelper alloc] initWitDatabase:@"carros.db"];
        [self createTables];
    }
    return self;
}

- (void) createTables {
    NSString *sql = @"create table if not exists carro (id integer primary key autoincrement, nome text, desc text, url_foto text, url_info text, url_video text, latitude text, longitude text, tipo text);";
    [db execSql:sql];
}

- (NSArray<Carro *> *) getCarrosByType:(NSString *)tipo {
    NSMutableArray<Carro *> *carros = [[NSMutableArray<Carro *> alloc] init];
    
    sqlite3_stmt * stmt =[db query:@"select * from carro where tipo = ?" witParams:[NSArray arrayWithObject:tipo]];
    
    while ([db nextRow:stmt]) {
        
        Carro * carro = [Carro alloc];
        [carro setIdentification:[db getInt:stmt withIndex:0]];
        [carro setNome:[db getString:stmt withIndex:1]];
        [carro setDesc:[db getString:stmt withIndex:2]];
        [carro setUrl_foto:[db getString:stmt withIndex:3]];
        [carro setUrl_info:[db getString:stmt withIndex:4]];
        [carro setUrl_video:[db getString:stmt withIndex:5]];
        [carro setLatitude:[db getString:stmt withIndex:6]];
        [carro setLongitude:[db getString:stmt withIndex:7]];
        [carro setTipo:[db getString:stmt withIndex:8]];
        
        [carros addObject:carro];
    }
    
    [db closeStatement:stmt];
    return carros;
}

- (void) save:(Carro *)carro {
    NSString * sql = nil;
    NSMutableArray * params = nil;
    if (carro.identification == 0) {
        sql = @"insert or replace into carro (nome, desc, url_foto, url_info, url_video, latitude, longitude, tipo) values (?, ?, ?, ?, ?, ?, ?, ?)";
        params = [NSMutableArray arrayWithObjects:carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.tipo, nil];
        
    } else {
        sql = @"update carro se nome = ?, desc = ?, url_foto = ?, url_info = ?, url_video = ?, latitude = ?, longitude = ?, tipo = ? where id = ? values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        params = [NSMutableArray arrayWithObjects:carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.tipo, carro.identification, nil];
    }
    
    [db execSql:sql withParams:params];
    NSLog(@"Carro %@ salvo com sucesso!", carro.nome);
}

- (void) delete:(Carro *)carro {
    NSString * sql = @"delete from carro where id = ?";
    [db execSql:sql withParams:[NSArray arrayWithObject:[NSNumber numberWithInt:carro.identification]]];
    NSLog(@"Carro %@ excluído com sucesso!", carro.nome);
}

- (void) deleteCarroByType:(NSString *)tipo {
    NSArray<Carro *> * carros = [self getCarrosByType:tipo];
    for (Carro *carro in carros) {
        [self delete:carro];
    }
}

- (void) close {
    [db close];
}

@end
