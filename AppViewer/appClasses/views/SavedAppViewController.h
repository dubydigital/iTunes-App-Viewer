//
//  SavedAppViewController.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "AppViewerModel.h"
#import "CoreDataUtil.h"

@interface SavedAppViewController : UITableViewController
<UITableViewDelegate,
UITableViewDataSource>{
    NSArray *_dataSourceArr;
}

@property(nonatomic,retain) NSArray *dataSourceArr;
-(void)calibrateDataSource;
@end
