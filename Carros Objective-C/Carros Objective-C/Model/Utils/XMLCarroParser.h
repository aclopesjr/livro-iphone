//
//  XMLCarroParser.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/8/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carro.h"

@interface XMLCarroParser : NSObject<NSXMLParserDelegate> {
    NSString * tempString;
    Carro * carro;
}

@property (nonatomic, strong) NSMutableArray *carros;


@end
