//
//  UploadViewController.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/11/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <KiiSDK/Kii.h>

@interface UploadViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    
    IBOutlet UITextField *mTitleField;
    IBOutlet UITextView *mBodyField;
    
    UIBarButtonItem *mDoneButton;
    IBOutlet UINavigationBar *mNavigationBar;
    
    CGRect defaultBodyFrame;
    
}

@property (nonatomic, retain) IBOutlet UITextField *mTitleField;
@property (nonatomic, retain) IBOutlet UITextView *mBodyField;

@property (nonatomic, retain) IBOutlet UINavigationBar *mNavigationBar;

- (IBAction) beginUpload:(id)sender;
- (IBAction) doneEditing:(id)sender;

@end
