//
//  AppDetailTableViewController.m
//  AppViewer
//
//  Created by Mark Dubouzet on 9/10/12.
//
//

#import "AppDetailTableViewController.h"

@interface AppDetailTableViewController ()

@end

@implementation AppDetailTableViewController
@synthesize appObject =_appObject;
@synthesize appImage;

-(void)dealloc{
    dispatch_release(backgroundQueue);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    self.appObject = nil;
    self.appImage = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style andAppObject:(AppObject*)appObject
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.appObject = appObject;
        
        // HIDE TABEL SEPARATOR
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        // DEFAULT IMAGE
        self.appImage = [UIImage imageNamed:@"DetailPlaceHolder.png"];
        
        
        // GET IMAGE
        [self performThreadDataFetch];
        
        // *** DETECT ROTATION FOR DETAIL SHARE BUTTONS
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    return self;
}

//---------------------------------------
#pragma mark Controller Methods
//---------------------------------------
- (void)receivedRotate:(NSNotification *)notification
{
    [self checkOrientation];
}
-(void)checkOrientation
{
    [self.tableView reloadData];
    
}

//---------------------------------------
#pragma mark - View lifecycle
//---------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkOrientation];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)performThreadDataFetch{
    [[self tableView] reloadData];
    backgroundQueue = dispatch_queue_create("com.dubydigital.appviewer.getdetailimageque", NULL);
    dispatch_async(backgroundQueue, ^(void) {
        [self setUpDetailImage];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            // PERFORM IN MAIN THREAD
            [[self tableView] reloadData];
        });
    });
}

-(void)setUpDetailImage{
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.appObject.imgDetailURLString]];
    self.appImage = [UIImage imageWithData:imgData];
}

//---------------------------------------
#pragma mark - Table view data source
//---------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return NUMBER_OF_DETAIL_ATTRIBUTES;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float rowHeight = 40;
    
    if (indexPath.row == DetailRowImageAndTitle) {
        rowHeight = 150.0;
    }
    
    if (indexPath.row == DetailRowSummary) {
        UILabel *label = [UILabel new];
        [label setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        [label setLineBreakMode:UILineBreakModeCharacterWrap];
        [label setNumberOfLines:0];
        label.font = [UIFont systemFontOfSize:12.0f];
        [label setText:[self.appObject summary]];
        CGSize labelSize;
        [label sizeToFit];
        labelSize = label.frame.size;
        //NSLog(@"label size after resizing: %f, %f ", labelSize.width, labelSize.height);
        
        rowHeight = label.frame.size.height;
        [label release];
    }
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ImageTitleCell";
    static NSString *CellIdentifierDetail = @"DetailCell";
    static NSString *CellIdentifierDetailShare = @"DetailShareCell";
    
    // IMAGE/ TITLE CELL
    UITableViewCell *imgTitleCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (imgTitleCell == nil) {
        imgTitleCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // DETAIL CELL
    UITableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierDetail];
    if (detailCell == nil) {
        detailCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierDetail] autorelease];
    }
    
    // DETAIL SHARE CELL
    DetailShareButtonsCell * shareButtonsCell =[tableView dequeueReusableCellWithIdentifier:CellIdentifierDetailShare ];
    if (shareButtonsCell == nil) {
        shareButtonsCell = [[DetailShareButtonsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierDetailShare] ;

        [shareButtonsCell autorelease];
    }
    
    // Configure the cell...
    
    imgTitleCell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    imgTitleCell.textLabel.numberOfLines = 0;
    imgTitleCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    //
    detailCell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    detailCell.textLabel.numberOfLines = 0;
    detailCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    detailCell.textLabel.backgroundColor = [UIColor clearColor];
    [detailCell.contentView setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.2]];
    
    switch (indexPath.row) {
        case DetailRowImageAndTitle:
            [[imgTitleCell imageView] setImage:self.appImage];
            [[imgTitleCell textLabel] setText:[self.appObject title]];
            
            return imgTitleCell;
            break;
        case DetailRowShare:
            [shareButtonsCell.contentView setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5]];
            return shareButtonsCell;
            
            break;
        case DetailRowPrice:
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"Price: $%0.2f",[self.appObject price] ]];
            return detailCell;

            break;
        case DetailRowSummary:
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"Summary: %@",[self.appObject summary]] ];
            [detailCell.contentView setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5]];
            return detailCell;
            break;
        case DetailRowDatelabel:
            
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"Date: %@",[self.appObject dateLabel]] ];
            return detailCell;
            break;
        case DetailRowURLLink:
            
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"URL: %@",[self.appObject linkURLString]] ];
            [detailCell.contentView setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5]];
            return detailCell;
            break;
        case DetailRowID:
            
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"Uniqure App ID: %@",[self.appObject idString]] ];
            return detailCell;
            break;
        case DetailRowArtist:
            
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"Artist: %@",[self.appObject artist]] ];
            [detailCell.contentView setBackgroundColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5]];
            return detailCell;
            break;
        case DetailRowCategory:
            
            [[detailCell textLabel] setText:[NSString stringWithFormat:@"Category: %@",[self.appObject category]] ];
            return detailCell;
            break;
            
            
        default:
            break;
    }
    return imgTitleCell;
}

//---------------------------------------
#pragma mark - Table view delegate
//---------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}




@end
