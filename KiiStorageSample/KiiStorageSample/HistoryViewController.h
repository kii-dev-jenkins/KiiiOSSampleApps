//
//  HistoryViewController.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/16/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *mTableView;
    
    NSMutableArray *mFileList;
    
}

@property (nonatomic, retain) IBOutlet UITableView *mTableView;

@end
