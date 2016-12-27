//
//  DetalhesCarroViewController.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Carro.h"
#import "DownloadImageView.h"

@interface DetalhesCarroViewController : UIViewController<UISplitViewControllerDelegate> {
    IBOutlet DownloadImageView * image;
    IBOutlet UITextView * descricao;
}

@property (nonatomic, strong) Carro * carro;

-(IBAction)visualizarMapa:(id)sender;

@end
