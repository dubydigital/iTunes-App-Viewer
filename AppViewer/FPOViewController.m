//
//  FPOViewController.m
//  AppViewer
//
//  Created by Mark Dubouzet on 9/11/12.
//
//

#import "FPOViewController.h"

@interface FPOViewController ()

@end

@implementation FPOViewController
@synthesize btntest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.btntest setAutoresizesSubviews:YES];
    [self.btntest setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
    

    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
