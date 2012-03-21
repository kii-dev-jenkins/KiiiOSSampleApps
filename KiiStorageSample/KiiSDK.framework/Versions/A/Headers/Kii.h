//
//  Kii.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/11/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KiiError.h"
#import "KiiCoreObject.h"
#import "KiiObject.h"
#import "KiiUser.h"
#import "KiiFile.h"
#import "KiiUtilities.h"
#import "KiiRequest.h"
#import "KiiQuery.h"

@class KiiFile, KiiUser;

/** The main SDK class
 
 This class must be initialized on application launch using beginWithKey:andSecret:forAppName:. This class also allows the application to make some high-level user calls and access some application-wide data at any time using static methods.
 */
@interface Kii : NSObject {
        
    NSString *mAppName;
    NSString *mAppID;
    NSString *mAppKey;
    
    KiiUser *currentUser;
    NSString *mAccessToken;
    NSDate *mAccessTokenExpires;

}

@property (nonatomic, retain) KiiUser *currentUser;

@property (nonatomic, retain) NSString *mAccessToken;
@property (nonatomic, retain) NSDate *mAccessTokenExpires;

+ (Kii*) sharedInstance;

/** Initialize the Kii SDK
 
 Should reside in applicationDidFinishLaunching:withResult:
 @param appKey The application key found in your Kii console
 @param appSecret The application secret found in your Kii console
 @param appName The application name found in your Kii console
 */
+ (void) beginWithID:(NSString*)appId andKey:(NSString*)appKey;
+ (void) shutDown;

+ (NSString*)baseURL;
+ (NSString*)appName;

/** Determines whether or not there is a KiiUser currently logged in
 @return TRUE if an authenticated user exists, FALSE otherwise
 */
+ (BOOL) loggedIn;

/** Logs the currently logged-in user out of the KiiSDK */
+ (void) logOut;

/** Get the currently logged-in user
 @return A KiiUser object representing the current user, nil if no user is logged-in
 */
+ (KiiUser*) currentUser;
+ (NSString*) accessToken;

+ (NSString*)appID;
+ (NSString*)appKey;

- (NSString*)accessToken;
- (NSString*)appKey;
- (NSString*)baseURL;
- (KiiUser*) currentUser;

- (void) setAccessToken:(NSString*)token expires:(NSNumber*)expires;

@end
