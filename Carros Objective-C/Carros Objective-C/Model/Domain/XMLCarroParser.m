//
//  XMLCarroParser.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/8/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "XMLCarroParser.h"
#import "Carro.h"

@implementation XMLCarroParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([@"carro" isEqualToString:elementName]) {
        carro = [Carro alloc];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"carros"]) {
        return;
    }
    
    if ([elementName isEqualToString:@"carro"]) {
        if ([self carros] == nil) {
            [self setCarros:[[NSMutableArray alloc] init]];
        }
        if (carro != nil)
            [[self carros] addObject:carro];
        
        carro = nil;
        return;
    }
    
    if (carro != nil) {
        if ([@"nome" isEqualToString:elementName]) {
            [carro setNome:tempString];
        } else if ([@"desc" isEqualToString:elementName]) {
            [carro setDesc:tempString];
        } else if ([@"url_foto" isEqualToString:elementName]) {
            [carro setUrl_foto:tempString];
        } else if ([@"url_info" isEqualToString:elementName]) {
            [carro setUrl_info:tempString];
        } else if ([@"url_video" isEqualToString:elementName]) {
            [carro setUrl_video:tempString];
        } else if ([@"latitude" isEqualToString:elementName]) {
            [carro setLatitude:tempString];
        } else if ([@"longitude" isEqualToString:elementName]) {
            [carro setLongitude:tempString];
        }
        tempString = @"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (tempString == nil)
        tempString = @"";
    
    tempString = [tempString stringByAppendingString:[string stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]];
}

@end
