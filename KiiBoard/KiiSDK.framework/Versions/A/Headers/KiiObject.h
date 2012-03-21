//
//  KiiObject.h
//  KiiSDK-Private
//
//  Created by Chris Beauchamp on 1/5/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "KiiCoreObject.h"


/** An application-level KiiCoreObject subclass
 
 This class gives an application the opportunity to create its own flexible class, derived from KiiCoreObject. Named by the application, this class can be manipulated, saved and retrieved just like any KiiCoreObject.
 */
@interface KiiObject : KiiCoreObject {
    
    NSString *className;

}

/** The application-defined class name of the object */
@property (readonly) NSString *className;


/** Create an empty KiiObject
 
 Creates an empty object for manipulation.
 @param name An application-specific class name
 @return a working KiiObject
 */
+ (KiiObject*) objectWithClassName:(NSString*)name;

@end
