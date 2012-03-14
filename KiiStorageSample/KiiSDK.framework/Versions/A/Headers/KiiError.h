//
//  KiiError.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 12/21/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Custom Kii SDK errors */
@interface KiiError : NSError


///---------------------------------------------------------------------------------------
/// @name Application Errors (1xx)
///---------------------------------------------------------------------------------------

/** The application received invalid credentials and was not initialized */
+ (KiiError*) invalidApplication;



///---------------------------------------------------------------------------------------
/// @name Connectivity Errors (2xx)
///---------------------------------------------------------------------------------------

/** Unable to connect to the internet */
+ (KiiError*) unableToConnectToInternet;

/** Unable to parse server response */
+ (KiiError*) unableToParseResponse;

///---------------------------------------------------------------------------------------
/// @name User API Errors (3xx)
///---------------------------------------------------------------------------------------

/** Unable to retrieve valid access token */
+ (KiiError*) invalidAccessToken;

/** Unable to authenticate user */
+ (KiiError*) unableToAuthenticateUser;

/** Unable to retrieve file list */
+ (KiiError*) unableToRetrieveUserFileList;

///---------------------------------------------------------------------------------------
/// @name File API Errors (4xx)
///---------------------------------------------------------------------------------------

/** Unable to delete file from cloud */
+ (KiiError*) unableToDeleteFile;

/** Unable to upload file to cloud */
+ (KiiError*) unableToUploadFile;

/** Unable to retrieve local file for uploading. May not exist, or may be a directory. */
+ (KiiError*) localFileInvalid;

/** Unable to shred file. Must be in the trash before it is permanently deleted. */
+ (KiiError*) shreddedFileMustBeInTrash;

///---------------------------------------------------------------------------------------
/// @name Core Object Errors (5xx)
///---------------------------------------------------------------------------------------

/** Invalid objects passed to method. Must be already saved on server. */
+ (KiiError*) invalidObjects;

/** Unable to parse object. Must be JSON-encodable */
+ (KiiError*) unableToParseObject;

/** Duplicate entry exists */
+ (KiiError*) duplicateEntry;

/** Invalid remote path set for KiiFile. Must be of form:  /root/path/subpath    */
+ (KiiError*) invalidRemotePath;

///---------------------------------------------------------------------------------------
/// @name Query Errors (6xx)
///---------------------------------------------------------------------------------------

/** No more query results exist */
+ (KiiError*) noMoreResults;

/** Query limit set too high */
+ (KiiError*) singleQueryLimitExceeded;

@end
