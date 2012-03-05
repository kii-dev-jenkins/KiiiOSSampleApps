//
//  UploadViewController.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/11/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <KiiSDK/Kii.h>

@interface UploadViewController : UIViewController {
    
    IBOutlet UISegmentedControl *mSegment;
    IBOutlet UIProgressView *mProgress;
    
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *mSegment;
@property (nonatomic, retain) IBOutlet UIProgressView *mProgress;

- (IBAction) beginUpload:(id)sender;

@end
