//
//  ListaCarrosViewController.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaCarrosViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    // MARK: Outlets
    IBOutlet UITableView * tabView;
    
    // MARK: Variables
    NSArray * carros;
}

@end
