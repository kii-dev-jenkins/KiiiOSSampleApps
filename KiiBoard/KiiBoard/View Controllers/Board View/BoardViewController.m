/*************************************************************************
 
 Copyright 2012 Kii Corporation
 http://kii.com
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 *************************************************************************/

#import "BoardViewController.h"

#import <KiiSDK/KiiClient.h>

#import "AppDelegate.h"
#import "CBToast.h"
#import "MessageCell.h"
#import "FromCell.h"
#import "NSString+Extensions.h"

@implementation BoardViewController

@synthesize tableView, enterMessageView, messageField;
@synthesize topic;


- (int) loadCells:(BOOL)withReload {
    
    NSLog(@"Loading cells");
    
    int prevCount = [cellList count];
    
    [cellList removeAllObjects];    
    
    BOOL left = FALSE;
    KiiObject *previousMessage = nil;
    
    for(KiiObject *message in messageList) {
        
        if(previousMessage == nil || (![[previousMessage getObjectForKey:@"creator_name"] isEqualToString:[message getObjectForKey:@"creator_name"]])) {
            
            left = !left;
            
            FromCell *from = [[FromCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FromCell"];
            from.title.text = [message getObjectForKey:@"creator_name"];
            
            if([cellList count] == 0) {
                from.title.frame = CGRectMake(0, 0, 320, 32);
            }
            
            [cellList addObject:from];
            [from release];
            
        }
        
        MessageCell *cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
        
        // Configure the cell...
        [cell setMessageOnLeft:[NSNumber numberWithBool:left]];
        [cell setMessageContent:[message getObjectForKey:@"content"] withTime:[NSString timeAgoFromDate:[message created]]];
        
        [cellList addObject:cell];
        
        [cell release];
        
        previousMessage = message;
    }
    
    NSLog(@"Cells: %@", cellList);
    
    if(withReload) {
        [self.tableView reloadData];
    }
    
    return [cellList count] - prevCount;
}


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
        
        [messageField setText:@""];
        
        [self.tableView beginUpdates];
        
        [messageList insertObject:post atIndex:0];
        
        int newCells = [self loadCells:FALSE];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        if(newCells == 1) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
        } else if(newCells == 2) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [indexPaths addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
        }
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];

        
    } else {
        [CBToast showToast:@"Error Posting!" withDuration:TOAST_LONG isPersistent:FALSE];
    }
    
}

- (IBAction)postMessage:(id)sender {
    
    [messageField resignFirstResponder];

    [CBToast showToast:@"Posting Message" withDuration:TOAST_SHORT isPersistent:TRUE];
    
    KiiObject *o = [KiiObject objectWithClassName:@"post"];
    [o setObject:[messageField text] forKey:@"content"];
    [o setObject:[[KiiClient currentUser] username] forKey:@"creator_name"];
    [o setObject:topic forKey:@"topic"];
    [o setObject:[KiiClient currentUser] forKey:@"creator"];
    [o save:self withCallback:@selector(donePosting:withError:)];
    
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
    cellList = [[NSMutableArray alloc] init];
    
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
    return [cellList count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Trying to draw");
    NSLog(@"Drawing[%d]: %@", indexPath.row, cellList);
    return [cellList objectAtIndex:indexPath.row];
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
    
    CGFloat retVal = indexPath.row == 0 ? 32.0f : 44.0f;
    
    NSLog(@"Trying to get height");
    
    UITableViewCell *cell = [cellList objectAtIndex:indexPath.row];
    
    NSLog(@"cell: %@", cell);
    
    int msgNdx = 0;
    for(int i=0; i<indexPath.row; i++) {
        if([[cellList objectAtIndex:i] isKindOfClass:[MessageCell class]]) {
            ++msgNdx;
        }
    }
    
    if([cell isKindOfClass:[MessageCell class]]) {
        KiiObject *message = [messageList objectAtIndex:msgNdx];
        [message describe];

        MessageCell *mcell = (MessageCell*)cell;
        
        NSString *time = [NSString timeAgoFromDate:[message created]];
        retVal = [MessageCell getCellHeight:[message getObjectForKey:@"content"] withTime:time isLeft:[[mcell messageOnLeft] boolValue]];
    }
    
    NSLog(@"Got height: %lf", retVal);
    
    return retVal;
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
	
    [self refresh];

}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    [self loadCells:TRUE];
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
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // shift the view up so the user can see both fields
    [UIView animateWithDuration:0.25f 
                          delay:0.0f 
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState 
                     animations:^{ 
                         [tableView setFrame:CGRectMake(0, 0, 320, 371-216)];
                         [enterMessageView setFrame:CGRectMake(0, self.view.frame.size.height - enterMessageView.frame.size.height - 216, 320, enterMessageView.frame.size.height)];
                     }
                     completion:^(BOOL complete) {

                         if(tableView.contentSize.height > tableView.frame.size.height) {
                             [tableView setContentOffset:CGPointMake(0, tableView.contentSize.height - tableView.frame.size.height) animated:TRUE];
                         }

                     }];
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    // shift the view up so the user can see both fields
    [UIView animateWithDuration:0.25f 
                          delay:0.0f 
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState 
                     animations:^{ 
                         [tableView setFrame:CGRectMake(0, 0, 320, 371)];
                         [enterMessageView setFrame:CGRectMake(0, self.view.frame.size.height - enterMessageView.frame.size.height, 320, enterMessageView.frame.size.height)];
                     }
                     completion:^(BOOL complete) {
                         
                         if(tableView.contentSize.height > tableView.frame.size.height) {
                             [tableView setContentOffset:CGPointMake(0, tableView.contentSize.height - tableView.frame.size.height) animated:TRUE];
                         }
                         
                     }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return FALSE;
}

@end
