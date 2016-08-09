//
//  CarroTableViewCell.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadImageView.h"

@interface CarroTableViewCell : UITableViewCell {
    IBOutlet UILabel * lNome;
    IBOutlet UILabel * lDescricao;
    IBOutlet DownloadImageView * ivImage;
}

@property (nonatomic, strong) UILabel * lNome;
@property (nonatomic, strong) UILabel * lDescricao;
@property (nonatomic, strong) DownloadImageView * ivImage;

@end
