//
//  AuthenticationViewController.h
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaddedTextField;

@interface AuthenticationViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet PaddedTextField *emailField;
@property (nonatomic, retain) IBOutlet PaddedTextField *passwordField;

- (IBAction)logIn:(id)sender;
- (IBAction)registerUser:(id)sender;

@end
