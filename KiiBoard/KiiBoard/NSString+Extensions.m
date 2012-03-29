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
        str = [NSString stringWithFormat:@"%dm %@",i,ago]; 
        
    } else if(t < 60*60*24) { 
        i = (int)floor(t/3600);
        str = [NSString stringWithFormat:@"%dh %@",i,ago]; 
        
    } else if(t < 60*60*24*7) { 
        i = (int)floor(t/86400);
        str = [NSString stringWithFormat:@"%dd %@",i,ago]; 
        
    } else if(t < 60*60*24*7*4) { 
        i = (int)floor(t/604800);
        str = [NSString stringWithFormat:@"%dw %@",i,ago]; 
        
    } else if(t < 60*60*24*7*4*12) { 
        i = (int)floor(t/2419200);
        str = [NSString stringWithFormat:@"%dmo %@",i,ago]; 
        
    } else { 
        i = (int)floor(t/29030400);
        str = [NSString stringWithFormat:@"%dy %@",i,ago]; 
        
    }
    
    return str;
}

@end
