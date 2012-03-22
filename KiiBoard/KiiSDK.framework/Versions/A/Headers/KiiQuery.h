//
//  KiiQuery.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 1/25/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KQWhere, KQExp;

/** A class to handle queries agains the data store.
 
 This class gives an application the opportunity to query the server for a refined set of results. A query must be initialized with a collection (class) to query against, can be composed of various attributes, and must contain either a KQWhere or KQExp clause for its main definition.
 */
@interface KiiQuery : NSObject {
    
    NSString *collection;
    
    int limit;
    
    KQWhere *where;
    
    NSString *start;
    NSString *cursor;
    NSString *sortString;
}

@property (nonatomic, retain) NSString *cursor;

/** Set the where clause/expression to execute
 
 When the query executes, it will execute the where clause provided. This clause may be a simple expression (KQExp) or a where clause (KQWhere) of any complexity.
 @param where This can be either a KQWhere or KQExp object
 */
- (void) setWhere:(id)where;


/** Set the maximum number of results to return
 
 The query will return a number of results 0 < N <= LIMIT, based on the total number of results.
 @param limit The limit for the query. Maximum limit is 100.
 */
- (void) setLimit:(int)limit;


/** Set the uuid of the first result in the set
 
 Will begin the query result set beginning at the uuid provided. The uuid is ignored if an object with this value does not exist in the collection.
 @param uuid The uuid to start at
 */
- (void) setStart:(NSString*)uuid;


/** Set the query to sort by a field in descending order
 
 If a sort has already been set, it will be overwritten.
 @param field The key that should be used to sort
 */
- (void) sortByDesc:(NSString*)field;


/** Set the query to sort by a field in ascending order
 
 If a sort has already been set, it will be overwritten.
 @param field The key that should be used to sort
 */
- (void) sortByAsc:(NSString*)field;


/** Determines if there are more results in the set
 
 If a result set is larger than the limit, there are more results to be found on the server and this method will return TRUE
 @return TRUE if there are more query results on the server, FALSE otherwise
 */
- (BOOL) hasNext;


/** Execute the current query
 
 The working query will be executed against the server, returning a result set. If the result set is restricted by the limit, the hasNext method will return true and the next set of results can be retrieved by getNext:withCallback:
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the query is completed
 */
- (void) execute:(id)delegate withCallback:(SEL)callback;


/** Get the next result set for the current query
 
 The next set of results will be retrieved from the server, based on the current query and the last results obtained. Again, if the result set is restricted by the limit, the hasNext method will return true and the next set of results can be retrieved by calling this method again.
 @param delegate The object to make any callback requests to
 @param callback The callback method to be called when the query is completed
 */
- (void) getNext:(id)delegate withCallback:(SEL)callback;


/** Create an empty KiiQuery object based on the provided class name.
 
 @param className An application-specific class name
 @return a working KiiQuery object
 */
+ (KiiQuery*) queryCollection:(NSString*)className;

@end
