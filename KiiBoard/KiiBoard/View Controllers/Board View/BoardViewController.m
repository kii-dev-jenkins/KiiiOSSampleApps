//
//  BoardViewController.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "BoardViewController.h"

#import <KiiSDK/Kii.h>

#import "AppDelegate.h"
#import "CBToast.h"
#import "MessageCell.h"
#import "NSString+Extensions.h"

@implementation BoardViewController

@synthesize tableView, messageView;
@synthesize topic;

#pragma mark - Retrieved Results
- (void) queryFinished:(KiiQuery*)query withResults:(NSArray*)messages andError:(KiiError*)error {
    
    NSLog(@"Listing complete");
    
    [CBToast hideToast];
    
    [messageList removeAllObjects];
    
    if(error == nil) {
        
        NSLog(@"Files: %@", messages);
        
        for(KiiObject *message in messages) {
            [messageList addObject:message];
            [message describe];
        }
        
    }
    
    [self doneLoadingTableViewData];
}

- (void) refresh {
    
    [CBToast showToast:@"Loading Messages" withDuration:TOAST_SHORT isPersistent:TRUE];

    KiiQuery *q = [KiiQuery queryCollection:@"posts"];
    [q setWhere:[KQWhere firstExpression:[KQExp equals:@"topic" value:topic]]];
    [q sortByDesc:@"modified"];
    [q setLimit:25];
    [q execute:self withCallback:@selector(queryFinished:withResults:andError:)];
    
}

- (void) donePosting:(KiiObject*)post withError:(KiiError*)error {
    
    [CBToast hideToast];
    
    if(error == nil) {
        
        [CBToast showToast:@"Message Posted!" withDuration:TOAST_LONG isPersistent:FALSE];
        
        [self.tableView beginUpdates];
        
        [messageList insertObject:post atIndex:0];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];

        
    } else {
        [CBToast showToast:@"Error Posting!" withDuration:TOAST_LONG isPersistent:FALSE];
    }
    
}

- (void) cancelMessage {
    
    [messageView setHidden:TRUE];
    [messageView resignFirstResponder];
    
}

- (void) postMessage {
    
    [messageView setHidden:TRUE];
    [messageView resignFirstResponder];

    [CBToast showToast:@"Posting Message" withDuration:TOAST_SHORT isPersistent:TRUE];
    
    KiiObject *o = [KiiObject objectWithClassName:@"post"];
    [o setObject:[messageView text] forKey:@"content"];
    [o setObject:[[Kii currentUser] username] forKey:@"creator_name"];
    [o setObject:topic forKey:@"topic"];
    [o setObject:[Kii currentUser] forKey:@"creator"];
    [o save:self withCallback:@selector(donePosting:withError:)];
    
}

- (void) createMessage {
    
    [messageView becomeFirstResponder];
    [messageView setHidden:FALSE];
    
    [self setTitle:@"Write Message"];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelMessage)];    
    [self.navigationItem setLeftBarButtonItem:cancel animated:TRUE];
    [cancel release];
    
    UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(postMessage)];    
    [self.navigationItem setRightBarButtonItem:post animated:TRUE];
    [post release];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
     
    self.title = [topic getObjectForKey:@"name"];
    
    messageList = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createMessage)];    
    [self.navigationItem setRightBarButtonItem:create];
    [create release];
    
    [self refresh];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    KiiObject *message = [messageList objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.nameLabel.text = [message getObjectForKey:@"creator_name"];
    [cell setMessageContent:[message getObjectForKey:@"content"]];
    cell.timeLabel.text = [NSString timeAgoFromDate:[message created]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KiiObject *message = [messageList objectAtIndex:indexPath.row];
    return [MessageCell getCellHeight:[message getObjectForKey:@"content"]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{		
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    [self refresh];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [self setTitle:[topic getObjectForKey:@"name"]];

    UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createMessage)];    
    [self.navigationItem setRightBarButtonItem:create animated:TRUE];
    [create release];
    
    [self.navigationItem setLeftBarButtonItem:nil animated:TRUE];
    
}

@end
