//
//  CarroService.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarroService : NSObject
+ (NSArray *) getCarros;
+ (NSArray *) getCarroByTypeFromFile:(NSString *)tipo;
+ (void) getCarrosByType:(NSString *)tipo withCache:(Boolean)cache andCallback:(void(^)(NSArray*, NSError*))callback;
+ (NSArray *) parserXML_SAX:(NSData *)data;
+ (NSArray *) parserXML_DOM:(NSData *)data;
+ (NSArray *) parserJSON:(NSData *)data;
@end
