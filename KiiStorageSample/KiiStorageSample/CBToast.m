//
//
//  Copyright 2012 Kii Corporation
//  http://kii.com
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//

#import "CBToast.h"

#import <QuartzCore/QuartzCore.h>

/*
 Set some pre-defined constants
 */
#define kCBToastPadding         20
#define kCBToastMaxWidth        220
#define kCBToastCornerRadius    8.0
#define kCBToastFadeDuration    0.5
#define kCBToastTextColor       [UIColor whiteColor]
#define kCBToastBottomPadding   30

@implementation CBToast

/*
 The only method - static - and shows a toast with a given message at either
 a constant (found above) or at a user-defined time (in milliseconds)
 */
+ (void) showToast:(NSString*)msg withDuration:(NSUInteger)durationInMillis {
    
    
    // build the toast label
    UILabel *toast = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    toast.text = msg;
    toast.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    toast.textColor = [UIColor whiteColor];
    toast.numberOfLines = 1000;
    toast.textAlignment = UITextAlignmentCenter;
    toast.lineBreakMode = UILineBreakModeWordWrap;
    toast.font = [UIFont systemFontOfSize:14.0f];
//    toast.alpha = 0.0f;
    toast.layer.cornerRadius = kCBToastCornerRadius;
    
    // resize based on message
    CGSize maximumLabelSize = CGSizeMake(kCBToastMaxWidth, 9999);
    CGSize expectedLabelSize = [toast.text sizeWithFont:toast.font 
                                        constrainedToSize:maximumLabelSize 
                                            lineBreakMode:toast.lineBreakMode]; 
    
    //adjust the label to the new height
    CGRect newFrame = toast.frame;
    newFrame.size = CGSizeMake(expectedLabelSize.width + kCBToastPadding, expectedLabelSize.height + kCBToastPadding);
    toast.frame = newFrame;
    
    // add the toast to the root window (so it overlays everything)
    [[[UIApplication sharedApplication] keyWindow] addSubview:toast];
    
    // get the window frame to determine placement
    CGRect windowFrame = [[UIApplication sharedApplication] keyWindow].frame;
    
    // set the Y-position so the base is 30 pixels off the bottom of the screen
    NSUInteger yOffset = windowFrame.size.height - (toast.frame.size.height / 2) - kCBToastBottomPadding;
    
    // align the toast properly
    toast.center = CGPointMake(160, yOffset);
    
    // round the x/y coords so they aren't 'split' between values (would appear blurry)
    toast.frame = CGRectMake(round(toast.frame.origin.x), round(toast.frame.origin.y), toast.frame.size.width, toast.frame.size.height);
        
    // set up the fade-in
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kCBToastFadeDuration];
    
    // values being aninmated
    toast.alpha = 1.0f;
    
    // perform the animation
    [UIView commitAnimations];

    
    
    // calculate the delay based on fade-in time + display duration
    NSTimeInterval delay = durationInMillis/1000 + kCBToastFadeDuration;
    
    // set up the fade out (to be performed at a later time)
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationDuration:kCBToastFadeDuration];
    [UIView setAnimationDelegate:toast];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    
    // values being animated
    toast.alpha = 0.0f;
    
    // commit the animation for being performed when the timer fires
    [UIView commitAnimations];

}

@end
