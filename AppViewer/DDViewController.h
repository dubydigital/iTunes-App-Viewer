//
//  DDViewController.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"

@interface DDViewController : UIViewController{
    
    MainTabViewController *mainTabViewController;
}

@property(nonatomic,retain) MainTabViewController *mainTabViewController;

@end
