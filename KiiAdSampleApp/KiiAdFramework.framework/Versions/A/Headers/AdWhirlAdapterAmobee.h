//
//  AdWhirlAdapterAmobee.h
//  AdSDK
//
//  Created by Chris Beauchamp on 3/6/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "AdWhirlAdNetworkAdapter.h"
#import "AdWhirlCustomAdView.h"
#import "AdWhirlWebBrowserController.h"
#import "AmobeeView.h"

@interface AdWhirlAdapterAmobee : AdWhirlAdNetworkAdapter <AdWhirlCustomAdViewDelegate, AdWhirlWebBrowserControllerDelegate> {
    BOOL requesting;
    CLLocationManager *locationManager;
    NSURLConnection *adConnection;
    NSMutableData *adData;
//    NSURLConnection *imageConnection;
//    NSMutableData *imageData;
    AmobeeView *adView;
    AdWhirlWebBrowserController *webBrowserController;
}

+ (AdWhirlAdNetworkType)networkType;

@end