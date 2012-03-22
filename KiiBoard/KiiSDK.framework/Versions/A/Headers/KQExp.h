//
//  KQExp.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 1/25/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Allows an application to construct an expression without dealing with query language */
@interface KQExp : NSObject {    
    NSString *expression;
}

- (NSString*)stringValue;

/** Create an expression of the form key = value
 @param key The key to compare
 @param value The value to compare
 */
+ (KQExp*)equals:(NSString*)key value:(id)value; 

/** Create an expression of the form key > value
 @param key The key to compare
 @param value The value to compare
 */
+ (KQExp*)greaterThan:(NSString*)key value:(id)value; 

/** Create an expression of the form key >= value
 @param key The key to compare
 @param value The value to compare
 */
+ (KQExp*)greaterThanOrEqual:(NSString*)key value:(id)value; 

/** Create an expression of the form key < value
 @param key The key to compare
 @param value The value to compare
 */
+ (KQExp*)lessThan:(NSString*)key value:(id)value; 

/** Create an expression of the form key <= value
 @param key The key to compare
 @param value The value to compare
 */
+ (KQExp*)lessThanOrEqual:(NSString*)key value:(id)value; 

@end
