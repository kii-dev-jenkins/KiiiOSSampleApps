//
//  AuthenticationViewController.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "AuthenticationViewController.h"

#import <KiiSDK/Kii.h>

#import "CBLoader.h"
#import "CBToast.h"

@implementation AuthenticationViewController

@synthesize emailField, passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *defEmail = [[NSUserDefaults standardUserDefaults] stringForKey:kPreferenceEmail];
    NSString *defPass = [[NSUserDefaults standardUserDefaults] stringForKey:kPreferencePassword];
    
    [emailField setText:defEmail];
    [passwordField setText:defPass];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {    
    [emailField release];
    [passwordField release];

    [super dealloc];
}

#pragma mark - Log In Methods
- (void) finishedLoggingIn:(KiiUser*)user withError:(KiiError*)error {
    
    [CBLoader hideLoader];
    
    // the user has logged in successfully
    if(error == nil) {
        
        // hide this view and get started
        [self dismissModalViewControllerAnimated:TRUE];
        
        [CBToast showToast:@"Logged in" withDuration:TOAST_LONG isPersistent:FALSE];
        
    } else {
        [CBToast showToast:@"Unable to log in" withDuration:TOAST_LONG isPersistent:FALSE];
    }
    
}

- (IBAction)logIn:(id)sender {
    
    // hide the keyboard
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    
    // show a loader
    [CBLoader showLoader:@"Logging In..."];
    
    NSString *email = [emailField text];
    NSString *password = [passwordField text];
    
    KiiUser *user = [KiiUser userWithEmail:email andPassword:password];
    [user authenticate:self withCallback:@selector(finishedLoggingIn:withError:)];
}


#pragma mark - Registration Methods
- (void) finishedRegistration:(KiiUser*)user withError:(KiiError*)error {
    
    [CBLoader hideLoader];
    
    // the user has logged in successfully
    if(error == nil) {
        
        [self dismissModalViewControllerAnimated:TRUE];

        [CBToast showToast:@"Registered + Logged in" withDuration:TOAST_LONG isPersistent:FALSE];
        
    } else {
        [CBToast showToast:@"Unable to register" withDuration:TOAST_LONG isPersistent:FALSE];
    }
    
}

- (IBAction)registerUser:(id)sender {
    
    // hide the keyboard
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    
    [CBLoader showLoader:@"Registering..."];
        
    NSString *email = [emailField text];
    NSString *password = [passwordField text];
    
    KiiUser *user = [KiiUser userWithEmail:email andPassword:password];
    [user performRegistration:self withCallback:@selector(finishedRegistration:withError:)];
    

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // shift the view up so the user can see both fields
    [UIView animateWithDuration:0.3f 
                          delay:0.0f 
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState 
                     animations:^{ 
                         [self.view setFrame:CGRectMake(0, -160, self.view.frame.size.width, self.view.frame.size.height)];
                     }
                     completion:nil];
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    // save the fields to preferences so the user doesn't have to type each time
    [[NSUserDefaults standardUserDefaults] setObject:[emailField text] forKey:kPreferenceEmail];
    [[NSUserDefaults standardUserDefaults] setObject:[passwordField text] forKey:kPreferencePassword];
    [[NSUserDefaults standardUserDefaults] synchronize];    
    
    // shift the view up so the user can see both fields
    [UIView animateWithDuration:0.3f 
                          delay:0.0f 
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState 
                     animations:^{ 
                         [self.view setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
                     }
                     completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return FALSE;
}

@end
