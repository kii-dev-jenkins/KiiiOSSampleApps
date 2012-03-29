//
//  FromCell.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/29/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "FromCell.h"

@implementation FromCell

@synthesize title;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 320, 20)];
        title.textAlignment = UITextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:12.0f];
        title.textColor = [UIColor colorWithWhite:0.517647059 alpha:1.0f];
        title.shadowColor = [UIColor whiteColor];
        title.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:title];
        
    }
    
    return self;
}

@end
