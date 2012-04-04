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

#import "RegistrationViewController.h"

#import <KiiSDK/KiiClient.h>

#import "CBLoader.h"
#import "CBToast.h"

#import "PaddedTextField.h"

@implementation RegistrationViewController

@synthesize container;
@synthesize usernameField, emailField, passwordField, confirmPasswordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
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
    [usernameField resignFirstResponder];
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    [confirmPasswordField resignFirstResponder];
        
    NSString *username = [usernameField text];
    NSString *email = [emailField text];
    NSString *password = [passwordField text];
    NSString *confirm = [confirmPasswordField text];

    NSString *errorString = nil;
    
    // do some preliminary checks on the fields
    if([username length] < 5) {
        errorString = @"Invalid username";
    } else if([email length] < 5) {
        errorString = @"Invalid email";
    } else if([password length] < 5) {
        errorString = @"Invalid password";
    } else if(![password isEqualToString:confirm]) {
        errorString = @"Password and confimation do not match";
    }
    
    
    // no preliminary errors, try to register
    if(errorString == nil) {
        
        [CBLoader showLoader:@"Registering..."];

        KiiUser *user = [KiiUser userWithEmail:email andPassword:password];
        [user setUsername:username];
        
        [user describe];
        
        [user performRegistration:self withCallback:@selector(finishedRegistration:withError:)];
        
    }
    
    // there was a basic error, have the user correct it
    else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [av show];
        [av release];
    }
    
    
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // shift the view up so the user can see both fields
    [UIView animateWithDuration:0.3f 
                          delay:0.0f 
                        options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState 
                     animations:^{ 
                         [container setFrame:CGRectMake(0, 0, 320, 460-216)];
                     }
                     completion:^(BOOL complete) {
                         [container setContentSize:CGSizeMake(320, 344)];
                     }];

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
                          [container setFrame:CGRectMake(0, 0, 320, 460)];
                      }
                      completion:^(BOOL complete) {
                          [container setContentSize:CGSizeMake(320, 344)];
                      }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return FALSE;
}

@end
