//
//  BoardViewController.h
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"

@class KiiObject;

@interface BoardViewController : UIViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    UITableView *tableView;
    UITextView *messageView;

    NSMutableArray *messageList;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextView *messageView;
@property (nonatomic, retain) KiiObject *topic;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
