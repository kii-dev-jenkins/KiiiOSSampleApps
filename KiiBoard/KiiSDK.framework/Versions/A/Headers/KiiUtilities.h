//
//  KiiUtilities.h
//  SampleApp
//
//  Created by Chris Beauchamp on 12/11/11.
//  Copyright (c) 2011 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KiiUtilities : NSObject

+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret;
+ (NSString *)urlEncode:(NSString*)string usingEncoding:(NSStringEncoding)encoding;

+ (void) callMethod:(SEL)method onDelegate:(id)delegate withObjects:(id)firstObj, ...;

@end
