//
//  CarroDBCoreData.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/30/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carro.h"

@interface CarroDBCoreData : NSObject

+ (Carro *)newInstance;

- (NSArray<Carro *> *)getCarrosByType:(NSString *)tipo;
- (void)save:(Carro *)carro;
- (void)delete:(Carro *)carro;
- (void)deleteCarrosByType:(NSString *)tipo;
- (void)close;

@end
