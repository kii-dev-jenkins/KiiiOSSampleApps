//
//  UploadViewController.m
//  SampleApp
//
//  Created by Chris Beauchamp on 12/11/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import "UploadViewController.h"

#import "CBToast.h"
#import "CBLoader.h"

#define kDefaultText    @"Enter text here"

@implementation UploadViewController

@synthesize mTitleField, mBodyField;
@synthesize mNavigationBar;

#pragma mark - IBActions
- (IBAction) doneEditing:(id)sender {
    [mBodyField resignFirstResponder];
}

- (void) uploadComplete:(KiiFile*)file withError:(NSError*)error {
    
    NSLog(@"Upload complete with error %@", error);
    
    [CBLoader hideLoader];
    
    if(error == nil) {
        [CBToast showToast:@"Note uploaded!" withDuration:TOAST_LONG];
    } else {
        [CBToast showToast:@"Upload failed!" withDuration:TOAST_LONG];
    }
    
    [file describe];
}

- (IBAction) beginUpload:(id)sender {
    
    if(![KiiClient loggedIn]) {
        [CBToast showToast:@"User is not logged in" withDuration:TOAST_LONG];
    } else if([[mTitleField text] length] == 0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a title for your note!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [av show];
        [av release];
    } else if([[mBodyField text] isEqualToString:kDefaultText]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter some text for your note!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [av show];
        [av release];
    } else {
        [CBLoader showLoader:@"Uploading note..."];
        
        // get the file path
        NSString *fileName = [NSString stringWithFormat:@"%@.txt", [mTitleField text]];
        
        NSURL *documentPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        documentPath = [documentPath URLByAppendingPathComponent:fileName];
        
        NSData *data = [[mBodyField text] dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:[documentPath path] atomically:YES];
        
        NSLog(@"Using file: %@ with content: %@", [documentPath path], [mBodyField text]);
        
        KiiFile *f = [KiiFile fileWithLocalPath:[documentPath path]];
        [f updateFile:self withCallback:@selector(uploadComplete:withError:)];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    defaultBodyFrame = mBodyField.frame;
    
    mDoneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing:)];

    [mBodyField setText:kDefaultText];

}

#pragma mark - View lifecycle
- (void) dealloc {
    
    [mTitleField release];
    [mBodyField release];
    
    [super dealloc];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {       
    [mNavigationBar.topItem setRightBarButtonItem:mDoneButton animated:TRUE];
    mBodyField.frame = CGRectMake(0, 44, 320, 200);
    
    if([[mBodyField text] isEqualToString:kDefaultText]) {
        [mBodyField setText:@""];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [mNavigationBar.topItem setRightBarButtonItem:nil animated:TRUE];
    mBodyField.frame = defaultBodyFrame;

    if([[mBodyField text] isEqualToString:@""]) {
        [mBodyField setText:kDefaultText];
    }

    return YES;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
