//
//  CarroDBCoreData.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/30/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//


#import "CarroDBCoreData.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation CarroDBCoreData

+ (Carro *)newInstance {
    NSManagedObjectContext * context = [CarroDBCoreData getContext];
    Carro * carro = (Carro *)[NSEntityDescription insertNewObjectForEntityForName:@"Carro" inManagedObjectContext:context];
    return carro;
}

+ (NSManagedObjectContext *)getContext {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

- (NSArray<Carro *> *)getCarrosByType:(NSString *)tipo {
    NSManagedObjectContext *context = [CarroDBCoreData getContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Carro" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tipo MATCHES %@", tipo];
    [request setPredicate:predicate];

    NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:true];
    NSArray<NSSortDescriptor *> *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *erro;
    NSArray *array = [context executeFetchRequest:request error:&erro];
    
    if (!array) {
        NSLog(@"Erro ao consultar Carros! %@", [erro localizedDescription]);
        return [NSArray<Carro *> alloc];
    }
    
    return (NSArray<Carro *> *)array;
}

- (void)save:(Carro *)carro {
    if (![carro timestamp]) {
        [carro setTimestamp:[[NSDate alloc] init]];
    }
    
    NSManagedObjectContext *context = [CarroDBCoreData getContext];
    
    NSError *erro = nil;
    [context save:&erro];
    if (!erro) {
        NSLog(@"Carro incluído com sucesso! %@", [carro nome]);
    } else {
        NSLog(@"Erro na inclusão do carro %@! %@", [carro nome], [erro localizedDescription]);
    }
}

- (void)delete:(Carro *)carro {
    NSManagedObjectContext *context = [CarroDBCoreData getContext];
    [context deleteObject:carro];
    
    NSError *erro = nil;
    [context save:&erro];
    if (!erro) {
        NSLog(@"Carro %@ excluído com sucesso!", [carro nome]);
    } else {
        NSLog(@"Erro ao excluir carro %@! %@", [carro nome], [erro localizedDescription]);
    }
}

- (void)deleteCarrosByType:(NSString *)tipo {
    NSArray<Carro *> *carros = [self getCarrosByType:tipo];
    
    while (carros.count > 0) {
        [self delete:[carros objectAtIndex:0]];
    }
}

- (void)close {
    
}

@end
