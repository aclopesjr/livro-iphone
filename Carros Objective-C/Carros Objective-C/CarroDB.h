//
//  CarroDB.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/24/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteHelper.h"
#import "Carro.h"

@interface CarroDB : NSObject {
    SQLiteHelper * db;
}

- (NSArray<Carro *> *) getCarrosByType:(NSString *)tipo;
- (void) save:(Carro *)carro;
- (void) delete:(Carro *)carro;
- (void) deleteCarroByType:(NSString *)tipo;
- (void) close;

@end
