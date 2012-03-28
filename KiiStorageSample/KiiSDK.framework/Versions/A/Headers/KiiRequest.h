//
//  KiiRequest.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 12/21/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KiiCoreObject, KiiCallback, KiiFile, KiiError;

typedef enum { GET, PUT, POST, FORMPOST, DELETE } HttpMethods;

@interface KiiRequest : NSObject {
        
    // these are dev-specific values
    KiiCallback *callback;
    
    NSValue *operation;
    
    KiiCoreObject *mObject;
    KiiFile *mFile;
    
    NSString *filePath;
    NSString *downloadPath;
    
    NSDictionary *postData;
    NSString *requestPath;
    int requestMethod;
    BOOL anonymous;
    
    BOOL complete;
    NSMutableData *responseData;
    NSError *responseError;
    NSInteger responseCode;
    long long responseExpectedSize;
    long long uploadFileSize;
    
}

@property (nonatomic, retain) NSValue *operation;

@property (nonatomic, retain) KiiCallback *callback;
@property (nonatomic, retain) KiiFile *mFile;

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
