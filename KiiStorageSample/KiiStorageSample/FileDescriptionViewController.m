//
//
//  Copyright 2012 Kii Corporation
//  http://kii.com
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
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
    NSString *fileName = [NSString stringWithFormat:@"%@.txt", [mFile uuid]];
    
    NSURL *documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentPath = [documentPath URLByAppendingPathComponent:fileName];

    [mFile getFileBody:[documentPath path] withDelegate:self andCallback:@selector(gotFileBody:atPath:withError:)];
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [CBLoader showLoader:@"Downloading note..."];
    
    // show the data associated with this file
    mUUIDLabel.text = [mFile uuid];
    mDataView.text = @"Downloading note...";
    
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterLongStyle];
    mUploadedLabel.text = [formatter stringFromDate:[mFile modified]];
	[formatter release];
    
}

@end
