//
//  DetailShareButtonsCell.h
//  AppViewer
//
//  Created by Mark Dubouzet on 9/11/12.
//
//

#import <Foundation/Foundation.h>
#import "AppObject.h"
#import "CoreDataUtil.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Constants.h"
#import "AppViewerModel.h"

@interface DetailShareButtonsCell : UITableViewCell
<UIAlertViewDelegate>
{
    UIButton *btnSave;
    UIButton *btnEmail;
    UIButton *btnTwitter;
    
    AppObject * _appObject;
}


@property(nonatomic,retain) AppObject * appObject;


-(void)saveHandler;
-(void)emailHandler;
-(void)twitterHandler;

@end
