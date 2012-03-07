//
//  KiiAdnet.h
//  AdSDK
//
//  Created by Chris Beauchamp on 2/28/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AdWhirlView.h"

@interface KiiAdnet : UIView <AdWhirlDelegate> {
    
    UIViewController *delegate;
    
    NSString *appId;
    NSString *appKey;
    
}

@property (nonatomic, assign) UIViewController *delegate;

+ (id) requestAdWithDelegate:(UIViewController*)del withApplicationId:(NSString*)aid andApplicationKey:(NSString*)akey;

@end
