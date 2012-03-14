//
//  KiiUser.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/14/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KiiCoreObject.h"


/** Contains user profile/account information and methods
 
 The user class allows an application to generate a user, register them with the server and log them in during subsequent sessions. Since KiiUser inherits from KiiCoreObject, the application can also set key/value pairs to this object.
 */

@class KiiError;
@interface KiiUser : KiiCoreObject {
    
    NSString *userId;
    
    NSString *accessToken;
    NSString *deviceId;
    
    NSString *username;    
    NSString *email;    
    NSString *password;    
}

/** Username to use for authentication or for display */
@property (readonly) NSString *username;

/** Password to use for authentication */
@property (readonly) NSString *password;

/** Email address to use for authentication or for display */
@property (readonly) NSString *email;

@property (readonly) NSString *userId;
@property (readonly) NSString *accessToken;

//@property (nonatomic, retain) NSString *deviceId;


/** Create an empty user object
 
 Creates an empty user object for manipulation. This user will not be authenticated until one of the authentication methods are called on it. However, it can accept key/value pairs before it is authenticated.
 @return a working KiiUser object
 */
+ (KiiUser*) user;


/** Create a user object with credentials pre-filled
 
 Creates an pre-filled user object for manipulation. This user will not be authenticated until one of the authentication methods are called on it. It can be treated as any other KiiCoreObject before it is authenticated
 @param email The user's email address
 @param password The user's password
 @return a working KiiUser object
 */
+ (KiiUser*) userWithEmail:(NSString*)email andPassword:(NSString*)password;


/** Asynchronously authenticates a user object with the server
 
 Authenticates a user with the server. The user object must have an associated email/password combination. This method is non-blocking.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) authenticate:(id)delegate withCallback:(SEL)callback;


/** Synchronously authenticates a user object with the server
 
 Authenticates a user with the server. The user object must have an associated email/password combination. This method is blocking.
 @param error A KiiError object, set to nil, to test for errors
 */
- (void) authenticateSynchronous:(KiiError**)error;


/** Asynchronously authenticates a user object with the server
 
 Authenticates a user with the server. The user object must have an associated email/password combination. This method is non-blocking.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) performRegistration:(id)delegate withCallback:(SEL)callback;


/** Synchronously registers a user object with the server
 
 Registers a user with the server. The user object must have an associated email/password combination. This method is blocking.
 @param error A KiiError object, set to nil, to test for errors
 */
- (void) performRegistrationSynchronous:(KiiError**)error;


/** Asynchronously update a user's password on the server
 
 Update a user's password with the server. The fromPassword must be equal to the current password associated with the account in order to succeed. This method is non-blocking.
 @param fromPassword The user's current password
 @param toPassword The user's desired password
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) updatePassword:(NSString*)fromPassword to:(NSString*)toPassword withDelegate:(id)delegate andCallback:(SEL)callback;


/** Synchronously update a user's password on the server
 
 Update a user's password with the server. The fromPassword must be equal to the current password associated with the account in order to succeed. This method is blocking.
 @param error A KiiError object, set to nil, to test for errors
 @param fromPassword The user's current password
 @param toPassword The user's desired password
 */
- (void) updatePasswordSynchronous:(KiiError**)error from:(NSString*)fromPassword to:(NSString*)toPassword;

@end
