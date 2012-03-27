//
//  KiiFile.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/12/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KiiError, KiiQuery;

/** Contains single file and file system information and methods
 
 The file class allows an application to create a file object and upload it to the server. Once stored, the file can be moved to trash, permanently deleted, updated and downloaded. 
 
 There are also File System methods available which are called statically, and provide system functions such as retrieving and emptying the trash.
 */
@interface KiiFile : NSObject {         

    NSString *container;
 
    NSString *uuid;
    NSString *localPath;
    NSString *mimeType;
    NSString *fileName;
    NSDate *modified;
    NSString *optional;
    NSNumber *fileSize;
    NSNumber *trashed;
}

/** The local path of a file to upload */
@property (nonatomic, retain) NSString *localPath;

/** The container of the file in storage */
@property (nonatomic, retain) NSString *container;

/** The remote ID of the file on the server */
@property (readonly) NSString *uuid;

/** The Content-Type of the file on the server */
@property (readonly) NSString *mimeType;

/** The file name of the file on the server */
@property (readonly) NSString *fileName;

/** The modified date of the file on the server */
@property (readonly) NSDate *modified;

/** An optional application-specific string, up to 512 bytes (UTF-8 encoded) */
@property (readonly) NSString *optional;

/** The size of the file on the server */
@property (readonly) NSNumber *fileSize;

/** A boolean value, TRUE if the file is in the trash, FALSE otherwise */
@property (readonly) NSNumber *trashed;

#pragma mark - file system methods

///---------------------------------------------------------------------------------------
/// @name File System Methods
///---------------------------------------------------------------------------------------

/** Get a list of all files associated with the logged in user at a specific container
 
 This is a non-blocking method.
 @param inContainer The container to be queried
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
+ (void) listAllFiles:(NSString*)inContainer withDelegate:(id)delegate andCallback:(SEL)callback;


/** Get a list of all files associated with the logged in user
 
 The query is performed on the default container. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
+ (void) listAllFiles:(id)delegate withCallback:(SEL)callback;


/** Get a list of all files associated with the logged in user
 
 This is a blocking method.
 @param inContainer The container to be queried
 @param err A KiiError object, passed by reference. Should only be tested if the method returns nil.
 @return An array of KiiFile objects. nil if there was an error - check the passed error value for a description.
 */
+ (NSArray*) listAllFilesSynchronous:(NSString*)inContainer withError:(KiiError**)err;


/** Get a list of all files associated with the logged in user
 
 The query is performed on the default container. This is a blocking method.
 @param err A KiiError object, passed by reference. Should only be tested if the method returns nil.
 @return An array of KiiFile objects. nil if there was an error - check the passed error value for a description.
 */
+ (NSArray*) listAllFilesSynchronous:(KiiError**)err;


/** Get a list of files currently in the trash of a specific container
 
 This is a non-blocking method.
 @param inContainer The container to be queried
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
+ (void) listTrash:(NSString*)inContainer withDelegate:(id)delegate andCallback:(SEL)callback;


/** Get a list of files currently in the trash
 
 The query is performed on the default container. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
+ (void) listTrash:(id)delegate withCallback:(SEL)callback;


/** Get a list of files currently in the trash of a specific container
 
 This is a non-blocking method.
 @param inContainer The container to be queried
 @param err A KiiError object, passed by reference. Should only be tested if the method returns nil.
 @return An array of KiiFile objects. nil if there was an error - check the passed error value for a description.
 */
+ (NSArray*) listTrashSynchronous:(NSString*)inContainer withError:(KiiError**)err;


/** Get a list of files currently in the trash
 
 The query is performed on the default container. This is a non-blocking method.
 @param err A KiiError object, passed by reference. Should only be tested if the method returns nil.
 @return An array of KiiFile objects. nil if there was an error - check the passed error value for a description.
 */
+ (NSArray*) listTrashSynchronous:(KiiError**)err;


/** Permanently deletes all contents within the trash of a specific virtual root
 
 This is a non-blocking method.
 @param inContainer The container for the trash to be emptied
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
+ (void) emptyTrash:(NSString*)inContainer withDelegate:(id)delegate andCallback:(SEL)callback;


/** Permanently deletes all contents within the trash
 
 This operation is performed on the default container. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
+ (void) emptyTrash:(id)delegate withCallback:(SEL)callback;


/** Permanently deletes all contents within the trash of a specific container
 
 This is a blocking method.
 @param inContainer The container for the trash to be emptied
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
+ (void) emptyTrashSynchronous:(NSString*)inContainer withError:(KiiError**)err;


/** Permanently deletes all contents within the trash
 
 This operation is performed on the default container. This is a blocking method.
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
+ (void) emptyTrashSynchronous:(KiiError**)err;


/** Search the available files in a specific container
 
 This is a blocking method.
 @param query The query to execute
 @param inContainer The container to perform the query on
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 @return An array of KiiFile objects in the query's result set
 */
+ (NSArray*) searchSynchronous:(KiiQuery*)query inContainer:(NSString*)inContainer withError:(KiiError**)err;


/** Search the available files
 
 This operation is performed on the default container. This is a blocking method.
 @param query The query to execute
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 @return An array of KiiFile objects in the query's result set
 */
+ (NSArray*) searchSynchronous:(KiiQuery*)query withError:(KiiError**)err;



#pragma mark - single file methods

///---------------------------------------------------------------------------------------
/// @name Single File Methods
///---------------------------------------------------------------------------------------

/** Generates an empty KiiFile object
 Uses the default container.
 @return A new KiiFile object
 */
+ (KiiFile*) file;


/** Generates an empty KiiFile object in a specified container
 @param inContainer The container the file should be created in
 @return A new KiiFile object
 */
+ (KiiFile*) file:(NSString*)inContainer;

/** Generates a KiiFile object based on a local file
 Uses the default container.
 @param localPath The path of the file to use
 @return A new KiiFile object
 */
+ (KiiFile*) fileWithLocalPath:(NSString*)localPath;


/** Generates a KiiFile object in a specific container based on a local file
 @param localPath The path of the file to use
 @param inContainer The container the file should be created in
 @return A new KiiFile object
 */
+ (KiiFile*) fileWithLocalPath:(NSString*)localPath inContainer:(NSString*)inContainer;


/** Generates a KiiFile object based on an existing file id
 Uses the default container.
 @param fileId The server ID of the file to use
 @return A new KiiFile object
 */
+ (KiiFile*) fileWithID:(NSString*)fileId;


/** Generates a KiiFile object based on an existing file id in a specific container
 @param fileId The server ID of the file to use
 @param inContainer The container the file should be retrieved from
 @return A new KiiFile object
 */
+ (KiiFile*) fileWithID:(NSString*)fileId inContainer:(NSString*)inContainer;


/** Updates the file data
 
 Updates the file data, overwriting the contents on the server with the local contents. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) updateFile:(id)delegate withCallback:(SEL)callback; //


/** Updates the file data
 
 Updates the file data, overwriting the contents on the server with the local contents. This is a blocking method.
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
- (void) updateFileSynchronous:(KiiError**)err; //


/** Refreshes the file metadata
 
 Updates the local KiiFile object with metadata from the server. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) getFileMetadata:(id)delegate withCallback:(SEL)callback; //


/** Refreshes the file metadata
 
 Updates the local KiiFile object with metadata from the server. This is a blocking method.
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
- (void) getFileMetadataSynchronous:(KiiError**)err; //


/** Retrieves the file body from the server
 
 Updates the local KiiFile object with the file body from the server. This is a non-blocking method.
 @param toPath The path of the file the body will be written to
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) getFileBody:(NSString*)toPath withDelegate:(id)delegate andCallback:(SEL)callback;


/** Retrieves the file body from the server
 
 Updates the local KiiFile object with the file body from the server. This is a non-blocking method.
 @param toPath The path of the file the body will be written to
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
- (void) getFileBodySynchronous:(NSString*)toPath withError:(KiiError**)err;


/** Permanently deletes a trashed file.
 
 If the file is not in the trash, an error is returned and the file remains as active. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) shredFile:(id)delegate withCallback:(SEL)callback;//


/** Permanently deletes a trashed file.
 
 If the file is not in the trash, an error is returned and the file remains as active. This is a blocking method.
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
- (void) shredFileSynchronous:(KiiError**)err;//


/** Moves the working file to the trash
 
 The file, once moved to trash, can be restored as long as the trash hasn't been emptied and the file hasn't been shredded since trashing the file. This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) moveToTrash:(id)delegate withCallback:(SEL)callback; //


/** Moves the working file to the trash
 
 The file, once moved to trash, can be restored as long as the trash hasn't been emptied and the file hasn't been shredded since trashing the file. This is a blocking method.
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
- (void) moveToTrashSynchronous:(KiiError**)err; //


/** Restores the working file from the trash
 
 This is a non-blocking method.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the request is completed
 */
- (void) restoreFromTrash:(id)delegate withCallback:(SEL)callback; //


/** Restores the working file from the trash
 
 This is a blocking method.
 @param err A KiiError object, passed by reference. If the error is nil, the request was successful. Otherwise, the error contains a description of the issue.
 */
- (void) restoreFromTrashSynchronous:(KiiError**)err; //



/** Prints the contents of this object to log
 
 For developer purposes only, this method prints the object in a readable format to the log for testing.
 */
- (void) describe;

@end


