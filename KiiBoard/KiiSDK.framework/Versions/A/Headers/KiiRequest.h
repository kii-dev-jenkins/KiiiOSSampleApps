//
//  KiiRequest.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 12/21/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KiiCoreObject, KiiError;

typedef enum { GET, PUT, POST, FORMPOST, DELETE } HttpMethods;

@interface KiiRequest : NSObject {
        
    // these are dev-specific values
    id callingDelegate;
    NSValue *callback;
    
    NSValue *operation;
    
    KiiCoreObject *mObject;
    
    NSString *filePath;
    NSString *downloadPath;
    
    NSDictionary *postData;
    NSString *requestPath;
    int requestMethod;
    BOOL anonymous;
    
}

@property (nonatomic, retain) NSValue *operation;

@property (nonatomic, retain) id callingDelegate;
@property (nonatomic, retain) NSValue *callback;

@property (nonatomic, retain) NSString *requestPath;
@property (nonatomic, retain) NSDictionary *postData;

@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSString *downloadPath;

@property (nonatomic, retain) KiiCoreObject *mObject;

- (id) initWithPath:(NSString*)path;

- (NSString*) getAccessToken;

- (void) setRequestMethod:(int)method;
- (void) setAnonymous:(BOOL)a;

- (NSDictionary*) makeSynchronousRequest:(KiiError**)sendError andResponse:(int*)response;
- (NSDictionary*) makeSynchronousRequest:(KiiError**)sendError;

@end
