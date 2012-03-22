//
//  KQWhere.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 1/25/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KQExp;

/** Allows an application to construct a query without dealing with query language */
@interface KQWhere : NSObject {
    
    NSString *whereExpression;
    
}

/** Append a KQExp with the AND operator 
 @param exp The expression to append
 */
- (void) andExp:(KQExp*)exp;


- (void) orExp:(KQExp*)exp;


- (void) notExp:(KQExp*)exp;


/** Append a KQWhere with the AND operator 
 @param exp The expression to append
 */
- (void) andWhere:(KQWhere*)exp;


- (void) orWhere:(KQWhere*)exp;


- (void) notWhere:(KQWhere*)exp;

/** Creates a compound KQWhere object
 @param exp The root KQWhere expression
 @return A usable KQWhere object
 */
+ (KQWhere*) firstWhere:(KQWhere*)exp;


/** Creates a compound KQWhere object
 @param exp The root KQExp expression
 @return A usable KQWhere object
 */
+ (KQWhere*) firstExpression:(KQExp*)exp;

- (NSString*) stringValue;

@end
