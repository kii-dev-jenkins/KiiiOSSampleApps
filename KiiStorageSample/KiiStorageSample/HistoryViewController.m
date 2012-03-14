//
//  HistoryViewController.m
//  SampleApp
//
//  Created by Chris Beauchamp on 12/16/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import "HistoryViewController.h"

#import <KiiSDK/Kii.h>
#import "CBLoader.h"
#import "FileDescriptionViewController.h"

@implementation HistoryViewController

@synthesize mTableView;

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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        
        // empty the trash
        
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    KiiFile *file = [mFileList objectAtIndex:indexPath.row];
    
    
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterLongStyle];
    cell.textLabel.text = [formatter stringFromDate:[file modified]];
	[formatter release];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void) deleteDone:(KiiFile*)file withError:(NSError*)error {
    
    NSLog(@"Delete complete: %@ withError: %@", file, error);
    
    // hide the loader
    [CBLoader hideLoader];
    
    if(error == nil) {
        
        int ndx = [mFileList indexOfObject:file];
        
        // Delete the row from the data source
        [mFileList removeObjectAtIndex:ndx];
        
        [mTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:ndx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

    }        

    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // show a loader
        [CBLoader showLoader:@"Removing File"];
        
        // remove the file asynchronously
        KiiFile *file = [mFileList objectAtIndex:indexPath.row];
        [file moveToTrash:self withCallback:@selector(deleteDone:withError:)];
        
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FileDescriptionViewController *vc = [[FileDescriptionViewController alloc] initWithNibName:@"FileDescriptionViewController" bundle:nil];
    vc.mFile = [mFileList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:TRUE];
    [vc release];
    
    // remove the highlight
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];

}

@end
