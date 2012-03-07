//
//  AdWhirlAdapterSmartMAD.h
//  AdSDK
//
//  Created by Chris Beauchamp on 3/6/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "AdWhirlAdNetworkAdapter.h"
#import "AdWhirlCustomAdView.h"
#import "AdWhirlWebBrowserController.h"

#import "SmartMadDelegate.h"
#import "SmartMadAdView.h"

@interface AdWhirlAdapterSmartMAD : AdWhirlAdNetworkAdapter <SmartMadAdViewDelegate, SmartMadAdEventDelegate> 

+ (AdWhirlAdNetworkType)networkType;

@end
