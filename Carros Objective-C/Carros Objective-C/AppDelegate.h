//
//  AppDelegate.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/4/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ListaCarrosViewController.h"
#import "DetalhesCarroViewController.h"
#import "SobreViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) ListaCarrosViewController *listaCarrosViewController;
@property (strong, nonatomic) DetalhesCarroViewController *detalhesCarroViewController;
@property (strong, nonatomic) SobreViewController *sobreViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

