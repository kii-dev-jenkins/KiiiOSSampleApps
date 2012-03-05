//
//  FileDescriptionViewController.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/17/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KiiFile;

@interface FileDescriptionViewController : UIViewController {
    
    KiiFile *mFile;
    
    IBOutlet UILabel *mUUIDLabel;
    IBOutlet UILabel *mUploadedLabel;
    IBOutlet UITextView *mDataView;
    
}

@property (nonatomic, retain) KiiFile *mFile;

@property (nonatomic, retain) IBOutlet UILabel *mUUIDLabel;
@property (nonatomic, retain) IBOutlet UILabel *mUploadedLabel;
@property (nonatomic, retain) IBOutlet UITextView *mDataView;

@end
