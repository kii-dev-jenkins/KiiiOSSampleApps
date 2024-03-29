//
//  KiiCoreObject.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/14/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UUID            @"uuid"
#define CREATED         @"created"
#define MODIFIED        @"modified"

@class KiiError;

/** The foundation for all Kii subclasses
 
 This class is the foundation for KiiUser, KiiFile and KiiObject subclasses. Each of its subclasses can call any of the methods or attributes within KiiCoreObject.
 */
@interface KiiCoreObject : NSObject {    
    NSString *uuid;
    NSMutableDictionary *customInfo;
    NSDate *created;
    NSDate *modified;
    
    NSMutableArray *deletedKeys;
}

/** Server-assigned global unique identifier for the object */
@property (readonly) NSString *uuid;

/** The date the object was created on the server */
@property (readonly) NSDate *created;

/** The date the object was last modified on the server */
@property (readonly) NSDate *modified;

/** Contains the attributes (key/value) pairs associated with this object */
@property (readonly) NSMutableDictionary *customInfo;

/** Get a specifically formatted string referencing the object. The object must exist in the cloud (have a valid UUID). */
@property (readonly) NSString *objectURI;

// TODO: Add refresh methods

/** Retrieves a readable class name for this object 
 
 If the object is user-defined, it will return the class name it was initialized with. If it is a Kii subclass, it will return a readable string value of that class.
 @return A string value of this object's class name
 */
- (NSString*) getClassName;


/** Sets a key/value pair to a KiiCoreObject
 
 If the key already exists, its value will be written over. If the object is of invalid type, it will return false and a KiiError will be thrown (quietly). Accepted types are any JSON-encodable objects.
 @param object The value to be set. Object must be of a JSON-encodable type (Ex: NSDictionary, NSArray, NSString, NSNumber, etc)
 @param key The key to set. The key must not be a system key (created, metadata, modified, type, uuid) or begin with an underscore (_)
 @return True if the object was set, false otherwise.
 */
- (BOOL) setObject:(id)object forKey:(NSString*)key;


/** Removes a specific key/value pair from the object
 If the key exists, the key/value will be removed from the object. Please note that the object must be saved before the changes propogate to the server.
 @param key The key of the key/value pair that will be removed
 */
- (void) removeObjectForKey:(NSString*)key;


/** Gets the value associated with the given key
 
 @param key The key to retrieve
 @return An object if the key exists, null otherwise
 */
- (id) getObjectForKey:(NSString*)key;


/** Asynchronously saves the latest object values to the server 
 
 If the object does not yet exist, it will be created. If the object already exists, the fields that have changed will be updated accordingly. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed. The callback method should have a signature similar to:
 
    - (void) objectSaved:(KiiCoreObject*)object withError:(NSError*)error {
 
        // the request was successful
        if(error == nil) {
            // do something with the object
        }
 
        else {
            // there was a problem
        }
    }
 
 */
- (void) save:(id)delegate withCallback:(SEL)callback;


/** Synchronously saves the latest object values to the server 
 
 If the object does not yet exist, it will be created. If the object already exists, the fields that have changed will be updated accordingly. This is a blocking method.
 @param error A KiiError object, set to nil, to test for errors
 */
- (void) saveSynchronous:(KiiError**)error;


/** Asynchronously updates the local object's data with the object data on the server
 
 The object must exist on the server. Local data will be overwritten.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed. The callback method should have a signature similar to:
 
    - (void) objectRefreshed:(KiiCoreObject*)object withError:(NSError*)error {
 
        // the request was successful
        if(error == nil) {
            // do something with the object
        }
 
        else {
            // there was a problem
        }
    }
 
 */
- (void) refresh:(id)delegate withCallback:(SEL)callback;


/** Synchronously updates the local object's data with the object data on the server
 
 The object must exist on the server. Local data will be overwritten. This is a blocking method.
 @param error A KiiError object, set to nil, to test for errors
 */
- (void) refreshSynchronous:(KiiError**)error;


/** Asynchronously deletes an object from the server. 
 
 Delete an object from the server. This method is non-blocking.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed. The callback method should have a signature similar to:
 
    - (void) objectDeleted:(KiiCoreObject*)object withError:(NSError*)error {
 
        // the request was successful
        if(error == nil) {
            // do something with the object
        }
 
        else {
            // there was a problem
        }
    }
 
 */
- (void) delete:(id)delegate withCallback:(SEL)callback;


/** Synchronously deletes an object from the server.

 Delete an object from the server. This method is blocking.
 @param error A KiiError object, set to nil, to test for errors
 */
- (void) deleteSynchronous:(KiiError**)error;


/** Prints the contents of this object to log
 
 For developer purposes only, this method prints the object in a readable format to the log for testing.
 */
- (void) describe;

@end
