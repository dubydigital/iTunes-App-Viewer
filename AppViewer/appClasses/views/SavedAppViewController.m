//
//  SavedAppViewController.m
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SavedAppViewController.h"

@implementation SavedAppViewController
@synthesize dataSourceArr =_dataSourceArr;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self calibrateDataSource];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)calibrateDataSource{
    self.dataSourceArr = [CoreDataUtil getAllSavedApps];
    [[self tableView] reloadData];
}

//---------------------------------------
#pragma mark - View lifecycle
//---------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0 ,0, self.view.bounds.size.width, 100)];
    
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 100)];
    [labelView setTextAlignment:UITextAlignmentCenter];
    [labelView setBackgroundColor:[UIColor orangeColor]];
    
    [labelView setLineBreakMode:UILineBreakModeCharacterWrap];
    [labelView setNumberOfLines:0];
    
    [labelView setText:@"Your saved apps will be viewed here, \nSwipe Table Cells Left to delete"];
    [labelView setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
    
    [headerView addSubview:labelView];
    self.tableView.tableHeaderView = headerView;
    
    [labelView release];
    [headerView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
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
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES; // ALLOWS FOR SWIPE TO DELETE CELLS
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [CoreDataUtil deleteSavedAppWithId:[(AppObject*)[self.dataSourceArr objectAtIndex:indexPath.row] idString]];
    NSLog(@"ID: %@",[(AppObject*)[self.dataSourceArr objectAtIndex:indexPath.row] idString]);
    self.dataSourceArr = [CoreDataUtil getAllSavedApps];
    [[self tableView] reloadData];
}




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
    return [self.dataSourceArr count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float rowHeight = 50.0f;
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [[cell textLabel] setText: [(AppObject*)[self.dataSourceArr objectAtIndex:indexPath.row] title]];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    
    return cell;
}

//---------------------------------------
#pragma mark - Table view delegate
//---------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
