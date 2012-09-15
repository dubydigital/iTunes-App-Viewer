//
//  BBExploreTabDelegate.h
//  Brabble
//
//  Created by Mark Dubouznet on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MainViewControllerDelegate <NSObject>

@required
-(void)launchTwitter;
-(void)launchEmail;
-(void)saveSelectedApp;
@end
