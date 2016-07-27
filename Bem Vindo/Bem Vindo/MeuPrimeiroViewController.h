//
//  MeuPrimeiroViewController.h
//  Bem Vindo
//
//  Created by Antonio Lopes on 7/25/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeuPrimeiroViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UILabel *meuPrimeiroLabel;
    IBOutlet UITextField *meuPrimeiroTextField;
    IBOutlet UITextField *meuSegundoTextField;
    IBOutlet UIImageView *imageView;
}

- (IBAction)olaMundo:(id)sender;

@end
