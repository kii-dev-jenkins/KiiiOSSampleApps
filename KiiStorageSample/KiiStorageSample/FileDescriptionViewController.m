//
//  FileDescriptionViewController.m
//  SampleApp
//
//  Created by Chris Beauchamp on 12/17/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import "FileDescriptionViewController.h"

#import <KiiSDK/KiiClient.h>

#import "CBLoader.h"
#import "CBToast.h"

@implementation FileDescriptionViewController

@synthesize mFile;
@synthesize mUUIDLabel, mUploadedLabel, mDataView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) gotFileBody:(KiiFile*)file atPath:(NSString*)atPath withError:(KiiError*)err {

    [CBLoader hideLoader];
    
    NSLog(@"Got file body: %@ atPath: %@ withError: %@", file, atPath, err);
    
    if(err == nil) {
        
        // put the body in the text field
        NSError *ferr = nil;
        NSString *body = [NSString stringWithContentsOfFile:atPath encoding:NSUTF8StringEncoding error:&ferr];
        [mDataView setText:body];
    
    } else {
        [mDataView setText:@"Error retrieving note!"];
    }
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    // get the file path
    NSString *fileName = [NSString stringWithFormat:@"%@.txt", [mFile fileId]];
    
    NSURL *documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentPath = [documentPath URLByAppendingPathComponent:fileName];

    [mFile getFileBody:[documentPath path] withDelegate:self andCallback:@selector(gotFileBody:atPath:withError:)];
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [CBLoader showLoader:@"Downloading note..."];
    
    // show the data associated with this file
    mUUIDLabel.text = [mFile fileId];
    mDataView.text = @"Downloading note...";
    
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterLongStyle];
    mUploadedLabel.text = [formatter stringFromDate:[mFile modified]];
	[formatter release];
    
}

@end
