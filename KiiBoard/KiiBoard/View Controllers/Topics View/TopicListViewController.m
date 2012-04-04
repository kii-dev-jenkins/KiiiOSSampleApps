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

#import "TopicListViewController.h"

#import <KiiSDK/KiiClient.h>

#import "BoardViewController.h"
#import "AuthenticationViewController.h"
#import "TopicListCell.h"

#import "CBToast.h"
#import "NSString+Extensions.h"

@implementation TopicListViewController

#pragma mark - Retrieved Results
- (void) queryFinished:(KiiQuery*)query withResults:(NSArray*)topics andError:(KiiError*)error {
    
    NSLog(@"Listing complete");
    
    [CBToast hideToast];
    
    [topicList removeAllObjects];
    
    if(error == nil) {
        
        NSLog(@"Files: %@", topics);
        
        for(KiiObject *topic in topics) {
            [topicList addObject:topic];
            [topic describe];
        }
        
    }
    
    [self doneLoadingTableViewData];

}

#pragma mark - Actions
- (void) logOut {
    [KiiClient logOut];
    
    [topicList removeAllObjects];
    [topicList release]; topicList = nil;
    
    [self.tableView reloadData];
    
    AuthenticationViewController *authenticationView = [[AuthenticationViewController alloc] initWithNibName:@"AuthenticationViewController" bundle:nil];
    [self.navigationController presentModalViewController:authenticationView animated:TRUE];
    [authenticationView release];
}

- (void) refresh {
    
    [CBToast showToast:@"Loading topics" withDuration:TOAST_SHORT isPersistent:TRUE];

    KiiQuery *q = [KiiQuery queryCollection:@"topic"];
    [q setLimit:25];
    [q sortByDesc:@"modified"];
    [q execute:self withCallback:@selector(queryFinished:withResults:andError:)];
    
}

- (void) topicCreated:(KiiObject*)topic withError:(KiiError*)error {
    
    [CBToast hideToast];

    if(error == nil) {
        
        [topic describe];
                
        [CBToast showToast:@"Topic created" withDuration:TOAST_LONG isPersistent:FALSE];
        
        [self.tableView beginUpdates];

        [topicList insertObject:topic atIndex:0];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                               withRowAnimation:UITableViewRowAnimationFade];
                
        [self.tableView endUpdates];

        /*
        BoardViewController *vc = [[BoardViewController alloc] initWithNibName:@"BoardViewController" bundle:nil];
        [vc setBoardId:[topic uuid]];
        [self.navigationController pushViewController:vc animated:TRUE];
        [vc release];
         */

    }
    
    else {
        [CBToast showToast:@"Unable to create topic" withDuration:TOAST_LONG isPersistent:FALSE];
    }
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSLog(@"string entered=%@ withButton: %d", topicName.text, buttonIndex);
    
    if(buttonIndex == 1 && [topicName.text length] > 0) {
        
        [CBToast showToast:@"Creating Topic" withDuration:TOAST_SHORT isPersistent:TRUE];
        
        KiiObject *topic = [KiiObject objectWithClassName:@"topic"];
        [topic setObject:topicName.text forKey:@"name"];
        [topic setObject:[KiiClient currentUser] forKey:@"creator"];
        [topic save:self withCallback:@selector(topicCreated:withError:)];
    }
    
    
}

- (void) createTopic {
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Create Topic"
                                                          message:@"this gets covered" 
                                                         delegate:self 
                                                cancelButtonTitle:@"Cancel" 
                                                otherButtonTitles:@"OK", nil];

    topicName = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [topicName setBackgroundColor:[UIColor whiteColor]];
    [myAlertView addSubview:topicName];
    [myAlertView show];
    [myAlertView release];
    
    [topicName becomeFirstResponder];
    
}

#pragma mark - View Lifecycle
- (void) viewDidAppear:(BOOL)animated {
    
    if(topicList == nil && [KiiClient loggedIn]) {
        topicList = [[NSMutableArray alloc] init];
        
        [self refresh];
    }
    
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

    self.title = @"Topics";
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.901960784 green:0.525490196 blue:0.125490196 alpha:1.0f]];
    
    UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createTopic)];
    [self.navigationItem setRightBarButtonItem:create];
    [create release];
    
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logOut)];
    [self.navigationItem setLeftBarButtonItem:logout animated:TRUE];
    [logout release];
        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [topicList count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor clearColor] : [UIColor colorWithWhite:0.905882353f alpha:1.0f];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";    
    TopicListCell *cell = (TopicListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TopicListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    KiiObject *topic = [topicList objectAtIndex:indexPath.row];

    // Configure the cell...
    cell.title.text = [topic getObjectForKey:@"name"];
    cell.time.text = [NSString timeAgoFromDate:[topic modified]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.backgroundView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor clearColor] : [UIColor colorWithWhite:0.905882353f alpha:1.0f];

    return (UITableViewCell*)cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KiiObject *topic = [topicList objectAtIndex:indexPath.row];
    [topic describe];

    BoardViewController *vc = [[BoardViewController alloc] initWithNibName:@"BoardViewController" bundle:nil];
    [vc setTopic:topic];
    [self.navigationController pushViewController:vc animated:TRUE];
    [vc release];

}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
    
    [self.tableView reloadData];
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
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

@end
