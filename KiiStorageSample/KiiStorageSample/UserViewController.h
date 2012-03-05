//
//  UserViewController.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/16/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIButton *mButton;
    IBOutlet UILabel *mUserId;

    IBOutlet UITextField *emailField;
    IBOutlet UITextField *passwordField;
    
}

@property (nonatomic, retain) IBOutlet UIButton *mButton;
@property (nonatomic, retain) IBOutlet UILabel *mUserId;

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction) performRegistration:(id)sender;
- (IBAction) performLogin:(id)sender;
- (IBAction) performLogout:(id)sender;

@end
