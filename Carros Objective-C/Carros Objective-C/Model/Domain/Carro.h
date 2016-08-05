//
//  Carro.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Carro : NSObject {
    
}

@property (nonatomic, strong) NSString * nome;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * url_foto;
@property (nonatomic, strong) NSString * url_info;
@property (nonatomic, strong) NSString * url_video;
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;

@end
