//
//  AppsTableViewController.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDetailTableViewController.h"
#import "AppViewerModel.h"
#import "AppObject.h"
#import "IconDownloader.h"
#import "Constants.h"


//#import "Constants.h"

#import "CoreDataUtil.h"

@interface AppsTableViewController : UITableViewController
<UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
IconDownloaderDelegate
>{
    NSArray *dataSourceArr;
    
    // MULTY THREAD
    dispatch_queue_t backgroundQueue;
    
    // ENUMS
    enum ServerFeedbackTypes _serverFeedbackType;
    
    // LAZY LOAD

    NSMutableDictionary *_imageDownloadsInProgress;
    
}

@property(nonatomic) enum ServerFeedbackTypes serverFeedbackType;
@property(nonatomic,retain) NSArray *dataSourceArr;
// THUMBNAIL DOWNLOAD PROPERTIES

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

#pragma mark Controller Methods
-(void)performThreadDataFetch;
-(void)processDataArr;



@end
