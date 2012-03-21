//
//  AuthenticationViewController.h
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationViewController : UIViewController <UITextFieldDelegate>
{
    
    /*
    UITextField *emailField;
    UITextField *passwordField;
    */
}

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction)logIn:(id)sender;
- (IBAction)registerUser:(id)sender;

@end
