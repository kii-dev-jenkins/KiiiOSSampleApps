//
//  UserViewController.m
//  SampleApp
//
//  Created by Chris Beauchamp on 12/16/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import "UserViewController.h"

#import <KiiSDK/Kii.h>
#import "CBLoader.h"

@implementation UserViewController

@synthesize mButton;
@synthesize mUserId;

@synthesize emailField, passwordField;

- (void) finishedLoggingIn:(KiiUser*)user withError:(KiiError*)error {
    
    [CBLoader hideLoader];
    
    // the user has logged in successfully
    if(error == nil) {
        
        // change the labels
        mUserId.text = [user uuid];
        
    }
    
}

- (IBAction) performLogin:(id)sender {
    
    // show our loader
    [CBLoader showLoader:@"Logging In..."];

    NSString *email = [emailField text];
    NSString *password = [passwordField text];
    
//    email = @"ios_test1@kii.com";
//    password = @"password";
    
    KiiUser *user = [KiiUser userWithEmail:email andPassword:password];
    [user authenticate:self withCallback:@selector(finishedLoggingIn:withError:)];
    
}

- (IBAction) performLogout:(id)sender {
    
    [Kii logOut];
    
    mUserId.text = @"- not logged in -";
    
}

- (void) finishedLoggingOut:(NSError*)error {
    
    [CBLoader hideLoader];
    
    if(error == nil) {
        
        // change the labels
        mUserId.text = @"- not logged in -";
        
        // and the button
        [mButton setTitle:@"Log In" forState:UIControlStateNormal];
    }
    
}

- (void) finishedRegistration:(KiiUser*)user withError:(KiiError*)error {
    
    [CBLoader hideLoader];
    
    // the user has logged in successfully
    if(error == nil) {
        
        // change the labels
        mUserId.text = [user uuid];
        
    }
    
}

- (IBAction) performRegistration:(id)sender {
    
    // show our loader
    [CBLoader showLoader:@"Registering User..."];
    
    NSString *email = [emailField text];
    NSString *password = [passwordField text];
    
    KiiUser *user = [KiiUser userWithEmail:email andPassword:password];
    [user performRegistration:self withCallback:@selector(finishedRegistration:withError:)];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {
    
    [mButton release];
    [mUserId release];
    
    [super dealloc];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
