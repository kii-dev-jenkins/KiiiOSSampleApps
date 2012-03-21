//
//  AppDelegate.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/20/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "AppDelegate.h"

#import "TopicListViewController.h"
#import "AuthenticationViewController.h"

#import <KiiSDK/Kii.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    [Kii beginWithID:@"4d95dcaa" andKey:@"9606978fddeed23e606b6701a55315d8"];

//    BoardViewController *masterViewController = [[BoardViewController alloc] initWithNibName:@"BoardViewController" bundle:nil];
    
    TopicListViewController *masterViewController = [[[TopicListViewController alloc] initWithNibName:@"TopicListViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    self.window.rootViewController = self.navigationController;

    [self.window makeKeyAndVisible];
    
    AuthenticationViewController *authenticationView = [[AuthenticationViewController alloc] initWithNibName:@"AuthenticationViewController" bundle:nil];
    [self.navigationController presentModalViewController:authenticationView animated:FALSE];
    [authenticationView release];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 Get an instance of this appdelegate class
 */
+ (AppDelegate *)sharedDelegate {
	return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
