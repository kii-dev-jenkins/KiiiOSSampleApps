//
//  TopicListViewController.h
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"

@interface TopicListViewController : UITableViewController <EGORefreshTableHeaderDelegate>
{
    
    UITextField *topicName;
    NSMutableArray *topicList;
	
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
