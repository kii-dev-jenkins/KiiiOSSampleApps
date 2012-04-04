//
//
//  Copyright 2012 Kii Corporation
//  http://kii.com
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//

#import "HistoryViewController.h"

#import <KiiSDK/KiiClient.h>
#import "CBLoader.h"
#import "CBToast.h"
#import "FileDescriptionViewController.h"

@implementation HistoryViewController

@synthesize mTableView;

- (IBAction) switchSource:(id)sender {
    
    UISegmentedControl *control = (UISegmentedControl*)sender;
    
    if([control selectedSegmentIndex] == 0) {
        // load the 'live' list
        [CBLoader showLoader:@"Loading file list"];
        [KiiFile listAllFiles:self withCallback:@selector(fileListingComplete:withError:)];
    } else {
        // load the 'trash' list
        [CBLoader showLoader:@"Loading trash list"];
        [KiiFile listTrash:self withCallback:@selector(fileListingComplete:withError:)];
    }
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) toggleEditing {
    [mTableView setEditing:!mTableView.isEditing animated:TRUE];

    UIBarButtonSystemItem item = (mTableView.isEditing) ? UIBarButtonSystemItemCancel : UIBarButtonSystemItemEdit;
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(toggleEditing)];
    [self.navigationItem setRightBarButtonItem:edit animated:TRUE];
    [edit release];

}

- (void) doneEmptying:(KiiError*)error {
    
    [CBLoader hideLoader];

    if(error == nil) {
        
        [CBToast showToast:@"Trash emptied!" withDuration:TOAST_LONG];
        
    } else {

        [CBToast showToast:@"Unable to empty trash!" withDuration:TOAST_LONG];

    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        
        // empty the trash
        [CBLoader showLoader:@"Emptying trash..."];
        
        [KiiFile emptyTrash:self withCallback:@selector(doneEmptying:)];
        
    }
    
}

- (void) showActionPanel {
    
    UIActionSheet *panel = [[UIActionSheet alloc] initWithTitle:@"Perform Action" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Empty Trash", nil];
    [panel showInView:[UIApplication sharedApplication].keyWindow];
    [panel release];
    
}

- (void) fileListingComplete:(NSArray*)files withError:(KiiError*)error {
    
    NSLog(@"Listing complete");
    
    [CBLoader hideLoader];
    
    [mFileList removeAllObjects];
    
    if(error == nil) {
        
        NSLog(@"Files: %@", files);
        
        for(KiiFile *f in files) {
            [mFileList addObject:f];
            [f describe];
        }
        
    }
    
    [mTableView reloadData];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"User Files";
    
    mFileList = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditing)];
    self.navigationItem.rightBarButtonItem = edit;
    [edit release];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *action = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionPanel)];
    self.navigationItem.leftBarButtonItem = action;
    [action release];
        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if(!animated) {
        [KiiFile listAllFiles:self withCallback:@selector(fileListingComplete:withError:)];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // if we're not popping from a description
    if(!animated) {
        
        // show a loader
        [CBLoader showLoader:@"Loading file list"];

    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mFileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    KiiFile *file = [mFileList objectAtIndex:indexPath.row];
    
    
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterLongStyle];
    cell.detailTextLabel.text = [formatter stringFromDate:[file modified]];
	[formatter release];

    cell.textLabel.text = [file fileName];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void) deleteDone:(KiiFile*)file withError:(NSError*)error {
    
    NSLog(@"Trash complete: %@ withError: %@", file, error);
    
    // hide the loader
    [CBLoader hideLoader];
    
    if(error == nil) {
        
        int ndx = [mFileList indexOfObject:file];
        
        // Delete the row from the data source
        [mFileList removeObjectAtIndex:ndx];
        
        [mTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:ndx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        [CBToast showToast:@"Unable to shred file" withDuration:TOAST_LONG];
    }
    
}

- (void) shredDone:(KiiFile*)file withError:(NSError*)error {
    
    NSLog(@"Shred complete: %@ withError: %@", file, error);
    
    // hide the loader
    [CBLoader hideLoader];
    
    if(error == nil) {
        
        int ndx = [mFileList indexOfObject:file];
        
        // Delete the row from the data source
        [mFileList removeObjectAtIndex:ndx];
        
        [mTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:ndx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        [CBToast showToast:@"Unable to shred file" withDuration:TOAST_LONG];
    }
    
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
                
        // remove the file asynchronously
        KiiFile *file = [mFileList objectAtIndex:indexPath.row];
        
        if([[file trashed] boolValue]) {
            [CBLoader showLoader:@"Shredding File"];
            [file shredFile:self withCallback:@selector(shredDone:withError:)];
        } else {
            [CBLoader showLoader:@"Trashing File"];
            [file moveToTrash:self withCallback:@selector(deleteDone:withError:)];
        }
        
    }
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileDescriptionViewController *vc = [[FileDescriptionViewController alloc] initWithNibName:@"FileDescriptionViewController" bundle:nil];
    vc.mFile = [mFileList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:TRUE];
    [vc release];
    
    // remove the highlight
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];

}

@end
