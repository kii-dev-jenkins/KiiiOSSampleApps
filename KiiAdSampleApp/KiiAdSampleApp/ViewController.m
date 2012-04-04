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
