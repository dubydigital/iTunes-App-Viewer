//
//  DDAppDelegate.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppViewerModel.h"
#import "CoreDataUtil.h"

@class DDViewController;

@interface DDAppDelegate : UIResponder <UIApplicationDelegate>{
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDViewController *viewController;


#pragma mark CORE DATA
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
