//
//  NSString+Extensions.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/21/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

+ (NSString*)timeAgoFromDate:(NSDate*)d {
    
    NSTimeInterval t = -1 * [d timeIntervalSinceNow];
    
    NSString *str = [NSLocalizedString(@"unknown date", @"time attached to a post - we don't know the time") capitalizedString];
    NSString *ago = NSLocalizedString(@"ago", @"time - when a comment was posted. Ex: 4 minutes ago");
    
    int i;
    if(t < 60) { str = [NSLocalizedString(@"just now", nil) capitalizedString]; } 
    else if(t < 60*60) { 
        i = (int)floor(t/60);
        
        NSString *minutes = (i==1) ? NSLocalizedString(@"minute", @"time - minute singular") : NSLocalizedString(@"minutes", @"time - minute plural");
        str = [NSString stringWithFormat:@"%d %@ %@",i,minutes,ago]; 
        
    } else if(t < 60*60*24) { 
        i = (int)floor(t/3600);
        
        NSString *hours = (i==1) ? NSLocalizedString(@"hour", @"time - hour singular") : NSLocalizedString(@"hours", @"time - hour plural");
        str = [NSString stringWithFormat:@"%d %@ %@",i,hours,ago]; 
        
    } else if(t < 60*60*24*7) { 
        i = (int)floor(t/86400);
        
        NSString *days = (i==1) ? NSLocalizedString(@"day", @"time - day singular") : NSLocalizedString(@"days", @"time - day plural");
        str = [NSString stringWithFormat:@"%d %@ %@",i,days,ago]; 
        
    } else if(t < 60*60*24*7*4) { 
        i = (int)floor(t/604800);
        
        NSString *weeks = (i==1) ? NSLocalizedString(@"week", @"time - week singular") : NSLocalizedString(@"weeks", @"time - week plural");
        str = [NSString stringWithFormat:@"%d %@ %@",i,weeks,ago]; 
        
    } else if(t < 60*60*24*7*4*12) { 
        i = (int)floor(t/2419200);
        
        NSString *months = (i==1) ? NSLocalizedString(@"month", @"time - month singular") : NSLocalizedString(@"months", @"time - month plural");
        str = [NSString stringWithFormat:@"%d %@ %@",i,months,ago]; 
        
    } else { 
        i = (int)floor(t/29030400);
        
        NSString *years = (i==1) ? NSLocalizedString(@"year", @"time - year singular") : NSLocalizedString(@"years", @"time - year plural");
        str = [NSString stringWithFormat:@"%d %@ %@",i,years,ago]; 
        
    }
    
    return str;
}

@end
