//
//  DetailShareButtonsCell.m
//  AppViewer
//
//  Created by Mark Dubouzet on 9/11/12.
//
//

#import "DetailShareButtonsCell.h"
#import "AppViewerModel.h"

@implementation DetailShareButtonsCell
@synthesize appObject = _appObject;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /*UIButton *btnSave;
        UIButton *btnEmail;
        UIButton *btnTwitter;*/
        

        
        //NSLog(@"DETAIL CELLs");
        float properWidth = 320;
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (orientation == UIDeviceOrientationLandscapeLeft||orientation==UIDeviceOrientationLandscapeRight)
        {
            properWidth = [[UIScreen mainScreen] bounds].size.height;
            // Set x coorinate of views you want to change
        }
        else
        {
            properWidth = [[UIScreen mainScreen] bounds].size.width;
            // Set x coordinates of views to initial x xoordinates.
        }

        btnSave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnSave addTarget:self action:@selector(saveHandler) forControlEvents:UIControlEventTouchUpInside];
        [btnSave setFrame:CGRectMake(0, 0, (properWidth/3), 40)];
        [btnSave setTitle:@"Save" forState:UIControlStateNormal];
        
        btnEmail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnEmail addTarget:self action:@selector(emailHandler) forControlEvents:UIControlEventTouchUpInside];
        [btnEmail setFrame:CGRectMake((properWidth/3), 0, (properWidth/3), 40)];
        [btnEmail setTitle:@"Email" forState:UIControlStateNormal];
        
        btnTwitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnTwitter addTarget:self action:@selector(twitterHandler) forControlEvents:UIControlEventTouchUpInside];
        [btnTwitter setFrame:CGRectMake(((properWidth/3)*2 ), 0, (properWidth/3), 40)];
        [btnTwitter setTitle:@"Twitter" forState:UIControlStateNormal];
        
        [self addSubview:btnSave];
        [self addSubview:btnEmail];
        [self addSubview:btnTwitter];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];    
    // Configure the view for the selected state
}


-(void)saveHandler{
    // CORE DATA TEST
    [CoreDataUtil saveAppToFavorites:[[AppViewerModel sharedInstance] currentAppInPlay] ];
}
-(void)emailHandler{
    if ([MFMailComposeViewController canSendMail]) {
        // Show the composer
        [[NSNotificationCenter defaultCenter] postNotificationName:EMAIL_LAUNCHED_NOTIFICATION object:nil];
    } else {
        // Handle the error
    }
}

-(void)twitterHandler{
    
}





@end