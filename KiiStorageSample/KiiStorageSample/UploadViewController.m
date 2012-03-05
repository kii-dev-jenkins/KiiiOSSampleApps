//
//  UploadViewController.m
//  SampleApp
//
//  Created by Chris Beauchamp on 12/11/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import "UploadViewController.h"

#import "CBToast.h"

@implementation UploadViewController

@synthesize mSegment, mProgress;

- (void) progressUpdated:(KiiFile*)file withValue:(NSNumber*)value {
    CGFloat percentage = [value floatValue];
    [mProgress setProgress:percentage];

    NSLog(@"Upload progress: %lf", percentage);
}

- (void) uploadComplete:(KiiFile*)file withError:(NSError*)error {
    
    NSLog(@"Upload complete with error %@", error);
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The upload completed. Check the log to see if there were any errors." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
    [av release];
    
    [file describe];
}

- (IBAction) beginUpload:(id)sender {
    
    if(![Kii loggedIn]) {
        [CBToast showToast:@"User is not logged in" withDuration:TOAST_LONG];
        return;
    }

    // get the desired file size
    int option = [mSegment selectedSegmentIndex];
    int size = 0;
    NSString *fileName = @"";
    switch (option) {
        case 0:
            size = 10 * 1024;
            fileName = @"10kb";
            break;
        case 1:
            size = 1024 * 1024;
            fileName = @"1mb";
            break;            
        case 2:
            size = 10 * 1024 * 1024;
            fileName = @"10mb";
            break;            
        default:
            break;
    }
    
    // get the file path
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"zip"];
    
    NSLog(@"Using file: %@", path);
        
    KiiFile *f = [KiiFile fileWithLocalPath:path];
    [f updateFile:self withCallback:@selector(uploadComplete:withError:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) dealloc {
    
    [mSegment release];
    [mProgress release];
    
    [super dealloc];
}

@end
