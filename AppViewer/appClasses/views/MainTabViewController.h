//
//  MainTabViewController.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppsTableViewController.h"
#import "SavedAppViewController.h"
#import "FPOViewController.h"
#import <MessageUI/MFMailComposeViewController.h>



@interface MainTabViewController : UITabBarController<UITabBarControllerDelegate,
MFMailComposeViewControllerDelegate>{
    UINavigationController *rootNavViewController;
    UINavigationController * appsNavigationController;
    
    AppsTableViewController * appsTableViewController;
    SavedAppViewController * savedAppViewController;
    
    NSArray *tabControllersArr;
}

@property(nonatomic,retain) UINavigationController *rootNavViewController;
@property(nonatomic,retain) AppsTableViewController * appsTableViewController;
@property(nonatomic,retain) SavedAppViewController * savedAppViewController;


-(void)setUpTabViewControllers;
-(void)launchEmail;

@end
