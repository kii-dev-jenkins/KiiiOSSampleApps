//
//  ViewController.m
//  KiiAdSampleApp
//
//  Created by Chris Beauchamp on 3/7/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "ViewController.h"

#import <KiiAdFramework/KiiAdNet.h>

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    KiiAdnet *adView = [KiiAdnet requestAdWithDelegate:self withApplicationId:@"ad5180b2" andApplicationKey:@"bb42cfa53de818ba9f940a26553c9ccd"];
    [self.view addSubview:adView];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
