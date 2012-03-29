//
//  RegistrationViewController.h
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/28/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaddedTextField;

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *container;
@property (nonatomic, retain) IBOutlet PaddedTextField *usernameField;
@property (nonatomic, retain) IBOutlet PaddedTextField *emailField;
@property (nonatomic, retain) IBOutlet PaddedTextField *passwordField;
@property (nonatomic, retain) IBOutlet PaddedTextField *confirmPasswordField;

- (IBAction)cancel:(id)sender;
- (IBAction)registerUser:(id)sender;



@end