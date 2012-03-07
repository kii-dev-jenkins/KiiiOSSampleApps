//
//  AmobeeView.h
//  AdSDK
//
//  Created by Chris Beauchamp on 2/29/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AdWhirlCustomAdView.h"

@interface AmobeeView : AdWhirlCustomAdView {
    UIWebView *webView;
}

@property (nonatomic, retain) UIWebView *webView;

- (id)initWithDelegate:(id<AdWhirlCustomAdViewDelegate>)delegate
                  text:(NSString *)text
           redirectURL:(NSURL *)redirectURL
       clickMetricsURL:(NSURL *)clickMetricsURL
                adType:(AWCustomAdType)adType
            launchType:(AWCustomAdLaunchType)launchType
              animType:(AWCustomAdWebViewAnimType)animType
       backgroundColor:(UIColor *)bgColor
             textColor:(UIColor *)fgColor;

@end
