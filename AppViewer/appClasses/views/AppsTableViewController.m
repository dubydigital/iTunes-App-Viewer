//
//  AppsTableViewController.m
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppsTableViewController.h"

@implementation AppsTableViewController
@synthesize dataSourceArr;
@synthesize serverFeedbackType = _serverFeedbackType;

@synthesize imageDownloadsInProgress = _imageDownloadsInProgress;

-(void)dealloc{

    dispatch_release(backgroundQueue);
    self.dataSourceArr = nil;
    self.imageDownloadsInProgress = nil;
   
    
    [super dealloc];
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        // INITIAL PROPERTIES
        self.serverFeedbackType = ServerFeedbackTypeLoading;
        
        // LAZY LOADING PROPERTIES
        self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
        
        // MULTI THREAD
        [self performThreadDataFetch];
        
        
        
        
    }
    return self;
}

//---------------------------------------
#pragma mark Controller Methods
//---------------------------------------

-(void)performThreadDataFetch{
    self.serverFeedbackType = ServerFeedbackTypeLoading;
    [[self tableView] reloadData];
    backgroundQueue = dispatch_queue_create("com.dubydigital.appviewer.getappque", NULL);
    dispatch_async(backgroundQueue, ^(void) {
        [self processDataArr];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            // PERFORM IN MAIN THREAD
            [[self tableView] reloadData];
        });
    });
}

-(void)processDataArr{
    self.dataSourceArr = [[AppViewerModel sharedInstance] getAppsArr];
    if ([self.dataSourceArr count]>0) {
        self.serverFeedbackType = ServerFeedbackTypeSuccess;
        
    }else{
        self.serverFeedbackType = ServerFeedbackTypeNone;
    }
}

/*// CUSTOM dataSourceArr Setter
-(void)setDataSourceArr:(NSArray *)newDataSourceArr{
    [newDataSourceArr retain];
    [dataSourceArr release];
    dataSourceArr = newDataSourceArr;
}*/

//---------------------------------------
#pragma mark - View lifecycle
//---------------------------------------
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

//---------------------------------------
#pragma mark - Table view data source
//---------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if ([self.dataSourceArr count] > 0) {
        return [self.dataSourceArr count];
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // CELL IDENTIFIER
    static NSString *LoadingCellIdentifier = @"LoadingCell";
    static NSString *SuccessCellIdentifier = @"SuccessCell";
    static NSString *NothingCellIdentifier = @"NothingCell";
    
    // LOADING
    UITableViewCell *loadingCell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
    if (loadingCell == nil) {
        loadingCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCellIdentifier] autorelease];
    }
    
    // SUCCESS
    UITableViewCell *sucessCell = [tableView dequeueReusableCellWithIdentifier:SuccessCellIdentifier];
    if (sucessCell == nil) {
        sucessCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuccessCellIdentifier] autorelease];
    }
    
    // NOTHING
    UITableViewCell *nothingCell = [tableView dequeueReusableCellWithIdentifier:NothingCellIdentifier];
    if (nothingCell == nil) {
        nothingCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NothingCellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (self.serverFeedbackType == ServerFeedbackTypeLoading) {
        [[loadingCell textLabel] setText: @"Loading Apps..."];
        loadingCell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        loadingCell.textLabel.numberOfLines = 0;
        loadingCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        return loadingCell;
    }
    
    if (self.serverFeedbackType == ServerFeedbackTypeNone) {
        [[nothingCell textLabel] setText: @"No Apps Were Loaded, Click to Reload"];
        nothingCell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        nothingCell.textLabel.numberOfLines = 0;
        nothingCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        return nothingCell;
    }
    
    if (self.serverFeedbackType == ServerFeedbackTypeSuccess) {
        // APP NAME
        NSString *tempName =  [(AppObject*)[self.dataSourceArr objectAtIndex:indexPath.row] name];
        sucessCell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        sucessCell.textLabel.numberOfLines = 0;
        sucessCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        [[sucessCell textLabel] setText:  tempName];
    }
    
    if ([self.dataSourceArr count] > 0)
    {
        // APP IMAGE
        AppObject *appObject = [self.dataSourceArr objectAtIndex:[indexPath row]];
        // Only load cached images; defer new downloads until scrolling ends
        if (!appObject.thumbImage)
        {
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
            {
                [self startIconDownload:appObject forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            [[sucessCell imageView] setImage:[UIImage imageNamed:@"Placeholder.png"]];
        }
        else
        {
            [[sucessCell imageView] setImage:appObject.thumbImage];
        }
    }
    
    return sucessCell;
}

//---------------------------------------
#pragma mark - Table view delegate
//---------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.serverFeedbackType == ServerFeedbackTypeSuccess) {
        // APP DETAIL
         AppDetailTableViewController * appDetailTableViewController =[[AppDetailTableViewController alloc] initWithStyle:UITableViewStylePlain andAppObject:[self.dataSourceArr objectAtIndex:indexPath.row]];
        
        [[AppViewerModel sharedInstance] setCurrentAppInPlay:[self.dataSourceArr objectAtIndex:indexPath.row]];
        
        [[appDetailTableViewController tableView] setDelegate:appDetailTableViewController];
        [[appDetailTableViewController tableView] setDataSource:appDetailTableViewController];
        [[appDetailTableViewController tableView]setFrame:[self.view bounds]];
        
        [[self navigationController] pushViewController:appDetailTableViewController animated:YES];
        [appDetailTableViewController release];
    }
    
    if (self.serverFeedbackType == ServerFeedbackTypeNone) {
        [self performThreadDataFetch];
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

//---------------------------------------
#pragma mark - DOWNLOAD THUMBNAILS
//---------------------------------------
- (void)startIconDownload:(AppObject *)appObject forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [_imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [IconDownloader new];
        iconDownloader.appObject = appObject;
        iconDownloader.indexPath = indexPath;
        iconDownloader.delegate = self;
        [_imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.dataSourceArr count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            if ([indexPath row] != [self.dataSourceArr count]) {
                AppObject *appObject = [self.dataSourceArr objectAtIndex:[indexPath row]];
                if (!appObject.thumbImage) // avoid the app icon download if the app already has an icon
                {
                    [self startIconDownload:appObject forIndexPath:indexPath];
                }
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [_imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:iconDownloader.indexPath];
        [[cell imageView] setAlpha:0];
        [[cell imageView] setImage:iconDownloader.appObject.thumbImage];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:0
                         animations: ^(void) {
                             [[cell imageView] setAlpha:1];
                         } completion: ^(BOOL finished){}];
    }
}

//---------------------------------------
#pragma mark - Deferred image loading (UIScrollViewDelegate)
//---------------------------------------
// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


@end
