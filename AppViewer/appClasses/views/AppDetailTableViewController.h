//
//  AppDetailTableViewController.h
//  AppViewer
//
//  Created by Mark Dubouzet on 9/10/12.
//
//

#import <UIKit/UIKit.h>
#import "AppObject.h"
#import "DetailShareButtonsCell.h"
#import "Constants.h"
#import "AppViewerModel.h"

@interface AppDetailTableViewController : UITableViewController
<
UITableViewDelegate,
UITableViewDataSource
>{
    AppObject *_appObject;
    // MULTY THREAD
    dispatch_queue_t backgroundQueue;
    UIImage* appImage;
}

@property(nonatomic,retain)UIImage* appImage;
@property(nonatomic,retain)AppObject *appObject;


- (id)initWithStyle:(UITableViewStyle)style andAppObject:(AppObject*)appObject;
-(void)performThreadDataFetch;
-(void)setUpDetailImage;
-(void)receivedRotate:(NSNotification *)notification;
-(void)checkOrientation;
@end
