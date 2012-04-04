/*************************************************************************
 
 Copyright 2012 Kii Corporation
 http://kii.com
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 *************************************************************************/

#import "UserViewController.h"

#import <KiiSDK/KiiClient.h>
#import "CBLoader.h"
#import "CBToast.h"

#define kPreferenceEmail        @"kii-storage-sample-pref-email"
#define kPreferencePassword     @"kii-storage-sample-pref-password"

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
        
        [CBToast showToast:@"Logged in" withDuration:TOAST_LONG];
        
    } else {
        [CBToast showToast:@"Unable to log in" withDuration:TOAST_LONG];
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
    
    [KiiClient logOut];
    
    mUserId.text = @"- not logged in -";
    
    [CBToast showToast:@"Logged out" withDuration:TOAST_LONG];
}

- (void) finishedRegistration:(KiiUser*)user withError:(KiiError*)error {
    
    [CBLoader hideLoader];
    
    // the user has logged in successfully
    if(error == nil) {
        
        // change the labels
        mUserId.text = [user uuid];
        
        [CBToast showToast:@"Registered + Logged in" withDuration:TOAST_LONG];
        
    } else {
        [CBToast showToast:@"Unable to register" withDuration:TOAST_LONG];
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
    
    // save the fields to prefs
    [[NSUserDefaults standardUserDefaults] setObject:[emailField text] forKey:kPreferenceEmail];
    [[NSUserDefaults standardUserDefaults] setObject:[passwordField text] forKey:kPreferencePassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
