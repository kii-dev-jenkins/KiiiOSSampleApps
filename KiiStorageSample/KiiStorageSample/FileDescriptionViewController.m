//
//  FileDescriptionViewController.m
//  SampleApp
//
//  Created by Chris Beauchamp on 12/17/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import "FileDescriptionViewController.h"

#import <KiiSDK/Kii.h>

#import "CBLoader.h"

@implementation FileDescriptionViewController

@synthesize mFile;
@synthesize mUUIDLabel, mUploadedLabel, mDataView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // show the data associated with this file
    mUUIDLabel.text = [mFile uuid];
    mDataView.text = [[mFile customInfo] description];
    
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterLongStyle];
    mUploadedLabel.text = [formatter stringFromDate:[mFile dateUploaded]];
	[formatter release];
    
}

@end
