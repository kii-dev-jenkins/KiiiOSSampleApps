//
//  AuthenticationViewController.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "AuthenticationViewController.h"

#import "RegistrationViewController.h"
#import "PaddedTextField.h"

#import <KiiSDK/KiiClient.h>

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
    
    NSString *email = nil;
    NSString *username = nil;
    NSString *password = [passwordField text];
    
    NSRange range = [[emailField text] rangeOfString:@"@" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound) {
        email = [emailField text];
    } else {
        username = [emailField text];
    }
        
    KiiUser *user = (email == nil) ? [KiiUser userWithUsername:username andPassword:password] : [KiiUser userWithEmail:email andPassword:password];
    [user authenticate:self withCallback:@selector(finishedLoggingIn:withError:)];
}


#pragma mark - Registration Methods
- (IBAction)registerUser:(id)sender {
    
    // hide the keyboard
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
        
    RegistrationViewController *vc = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
    [self presentModalViewController:vc animated:TRUE];
    [vc release];

}

#pragma mark - UITextFieldDelegate
- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    // save the fields to preferences so the user doesn't have to type each time
    [[NSUserDefaults standardUserDefaults] setObject:[emailField text] forKey:kPreferenceEmail];
    [[NSUserDefaults standardUserDefaults] setObject:[passwordField text] forKey:kPreferencePassword];
    [[NSUserDefaults standardUserDefaults] synchronize];    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return FALSE;
}

- (void) viewDidAppear:(BOOL)animated {
    
    NSLog(@"VWA: %@ : %d", [KiiClient currentUser], [KiiClient loggedIn] ? 1 : 0);
    
    if([KiiClient loggedIn]) {
        [self dismissModalViewControllerAnimated:TRUE];
    }
    
}

@end
