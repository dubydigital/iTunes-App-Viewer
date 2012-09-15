//
//  MainTabViewController.m
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainTabViewController.h"

@implementation MainTabViewController

@synthesize rootNavViewController;
@synthesize appsTableViewController;
@synthesize savedAppViewController;


-(void)dealloc{
    // LAUNCH EMAIL NOTIFICATION
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [appsNavigationController release];
    [rootNavViewController release];
    [appsTableViewController release];
    [savedAppViewController release];

    [tabControllersArr release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"MainTabViewController constructor:");
        [self setDelegate:self];
        // Custom initialization
        
        // LAUNCH EMAIL NOTIFICATION
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchEmail) name:EMAIL_LAUNCHED_NOTIFICATION object:nil];
    }
    return self;
}

-(void)setUpTabViewControllers{
    // CREATE TAB BAR CONROLLERS:
    
    // APPS TABLE SECTION
    appsTableViewController =[[AppsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [[appsTableViewController tableView] setDelegate:appsTableViewController];
    [[appsTableViewController tableView] setDataSource:appsTableViewController];
    [[appsTableViewController tableView]setFrame:[self.view bounds]];
    
    // UINAVIGATION CONTROLLER
    appsNavigationController =[[UINavigationController alloc] initWithRootViewController:appsTableViewController];
    
    // SAVED TAB SECTION
    savedAppViewController =[[SavedAppViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [[savedAppViewController tableView] setDelegate:savedAppViewController];
    [[savedAppViewController tableView] setDataSource:savedAppViewController];
    [[appsTableViewController tableView]setFrame:[self.view bounds]];
    
    /*/ FPO ViewController
    FPOViewController *fpoViewController =[[FPOViewController alloc] initWithNibName:@"FPOViewController" bundle:nil];*/
    
    // CREATE CONTROLLERS ARRAY
    tabControllersArr =[[NSArray alloc] initWithObjects:
                        appsNavigationController,savedAppViewController, nil];
    
    // SET VIEW CONTROLLERS
    [self setViewControllers:tabControllersArr];
    [self setSelectedViewController:[tabControllersArr objectAtIndex:0]];
    
    // SET TAB TITLES
    UITabBarItem *tabBarItem1 = [[self.tabBar items] objectAtIndex:0];
    [tabBarItem1 setTitle:@"iTunes Apps"];
    
    UITabBarItem *tabBarItem2 = [[self.tabBar items] objectAtIndex:1];
    [tabBarItem2 setTitle:@"Saved Apps"];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//---------------------------------------
#pragma mark - View lifecycle
//---------------------------------------
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

//---------------------------------------
#pragma mark - Tab Bar
//---------------------------------------
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    // TRACK TABS
    switch (tabBarController.selectedIndex) {
        case TabBarSectionApps:
        {
            NSLog(@"TabBar selected index: 0");
            break;
        }
        case TabBarSectionSavedApps:{
            
            [savedAppViewController calibrateDataSource];
            
            NSLog(@"TabBar selected index: 1");
            break;
        }
            
        default:
            break;
    }
}

//---------------------------------------
#pragma mark MAIL Methods
//---------------------------------------
-(void)launchEmail{
    
    
    NSString *subjectString = [NSString stringWithFormat:@"Check This App out: %@",[[AppViewerModel sharedInstance] currentAppInPlay].title];
    NSString *messageStrig =[NSString stringWithFormat:@"Check Out %@, here is the link: %@  ,cheers!",[[AppViewerModel sharedInstance] currentAppInPlay].title, [[AppViewerModel sharedInstance] currentAppInPlay].linkURLString];
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:subjectString];
    [controller setMessageBody:messageStrig isHTML:NO];
    if (controller) [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
