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
	
    KiiAdnet *adView = [KiiAdnet requestAdWithDelegate:self withApplicationId:@"d35b57a5" andApplicationKey:@"96f8cb72c806db4da817522de6475655"];
    [adView setTestMode:TRUE];
    
    [self.view addSubview:adView];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - KiiAdnet Delegate
- (void) failedToReceiveAd:(KiiAdnet*)adView {
    NSLog(@"Really failed %@", adView);
}

- (void) servedAd:(KiiAdnet*)adView {
    NSLog(@"Ad served to view: %@", adView);
}


@end
