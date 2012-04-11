//
//  KiiAdnet.h
//  AdSDK
//
//  Created by Chris Beauchamp on 2/28/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AdWhirlView.h"

@class KiiAdnet;


/** KiiAdnet Delegate Methods
 
 Register these methods in order to get updates about the status of the ad view.
 */
@protocol KiiAdnetDelegate <NSObject>

@optional

/** Called when a fresh ad is served to the view
 
 @param adView The ad view in which the new ad is displayed
*/ 
- (void) servedAd:(KiiAdnet*)adView;

/** Called when an ad view is unable to receive an ad
 
 @param adView The ad view in which the failure occured
 */ 
- (void) failedToReceiveAd:(KiiAdnet*)adView;

@end


/** The main interface for implementing the KiiAdNetwork
 
 KiiAdnet is the driver for displaying Kii Ads within your application. The majority of ad management is done online via the administrative console, making the SDK implementation very simple.
 
 Create an instance of KiiAdNet using its static constructor within the view controller in which you'd like your ad to appear. Then go to the online console to set up your ad networks.
 
 Implements the KiiAdnetDelegate protocol
 
 See a working example at: http://github.com/kii-dev-jenkins
 */
@interface KiiAdnet : UIView <AdWhirlDelegate> {
    
    UIViewController *delegate;
    
    NSString *appId;
    NSString *appKey;
    
    NSMutableArray *_keywords;
        
}

@property (nonatomic, assign) UIViewController *delegate;

/** Set a user's postal code for targeting (Ex: 94401) */
@property (nonatomic, retain) NSString *postalCode;

/** Set a user's date of birth for targeting */
@property (nonatomic, retain) NSDate *dateOfBirth;

/** Set a user's gender for targeting. Can be 'm' or 'f' */
@property (nonatomic, retain) NSString *gender;

/** Set to true if test ads should be shown, false if otherwise. */
@property (nonatomic, assign) BOOL testMode;


///---------------------------------------------------------------------------------------
/// @name Displaying ads
///---------------------------------------------------------------------------------------

/** Generate an instance of KiiAdNet
 
 By adding this method to a view controller, the SDK will load your ad configuration from the online console and display the appropriate ads within the view controller.
 @param del The view controller in which the ads should be displayed
 @param aid Your application's ID (found in the console)
 @param akey Your application's key (found in the console)
 @return An instance of KiiAdNet
 */
+ (id) requestAdWithDelegate:(UIViewController*)del withApplicationId:(NSString*)aid andApplicationKey:(NSString*)akey;

///---------------------------------------------------------------------------------------
/// @name Targeting
///---------------------------------------------------------------------------------------

/** Add a keyword for targeting
 
 @param keyword The keyword to add
 */
- (void) addKeyword:(NSString*)keyword;

/** Remove a keyword from targeting
 
 @param keyword The keyword to remove
 */
- (void) removeKeyword:(NSString*)keyword;


/** Retrieve a list of current keywords
 
 @return A space-delimited string of keywords
 */
- (NSString*)keywords;


@end
